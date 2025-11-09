import Flutter
import UIKit
import SafariServices
import PassKit

public class SwiftPaymentPlugin: NSObject,FlutterPlugin ,SFSafariViewControllerDelegate, OPPCheckoutProviderDelegate, OPPThreeDSEventListener, PKPaymentAuthorizationViewControllerDelegate, UIAdaptivePresentationControllerDelegate   {
    var type:String = "";
    var mode:String = "";
    var checkoutid:String = "";
    var brand:String = "";
    var brandsReadyUi:[String] = [];
    var STCPAY:String = "";
    var number:String = "";
    var holder:String = "";
    var year:String = "";
    var month:String = "";
    var cvv:String = "";
    var pMadaVExp:String = "";
    var prMadaMExp:String = "";
    var brands:String = "";
    var shopperResultURL:String = "";
    var tokenID:String = "";
    var payTypeSotredCard:String = "";
    var applePaybundel:String = "";
    var countryCode:String = "";
    var currencyCode:String = "";
    var setStorePaymentDetailsMode:String = "";
    var lang:String = "";
    var amount:Double = 1;
    var themColorHex:String = "";
    var companyName:String = "";
    var supportedNetworks:[String] = [];
    var safariVC: SFSafariViewController?
    var transaction: OPPTransaction?
    var provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    var checkoutProvider: OPPCheckoutProvider?
    var Presult:FlutterResult?
    var window: UIWindow?
    var presentedThreeDSNavigationController: UINavigationController?
    var isThreeDSProcessActive: Bool = false
    

  public static func register(with registrar: FlutterPluginRegistrar) {
    let flutterChannel:String = "Hyperpay.demo.fultter/channel";
    
    let channel = FlutterMethodChannel(name: flutterChannel, binaryMessenger: registrar.messenger())
    
    let instance = SwiftPaymentPlugin()
    registrar.addApplicationDelegate(instance)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.Presult = result

        if call.method == "gethyperpayresponse"{
            guard let args = call.arguments as? Dictionary<String,Any> else {
                result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments format", details: nil))
                return
            }
            
            self.type = (args["type"] as? String) ?? ""
            self.mode = (args["mode"] as? String) ?? ""
            self.checkoutid = (args["checkoutid"] as? String) ?? ""
            self.shopperResultURL = (args["ShopperResultUrl"] as? String) ?? ""
            self.lang = (args["lang"] as? String) ?? ""
            self.supportedNetworks = (args["supportedNetworks"] as? [String]) ?? []

            if self.type == "ReadyUI" {
                self.applePaybundel = (args["merchantId"] as? String) ?? ""
                self.countryCode = (args["CountryCode"] as? String) ?? ""
                self.companyName = (args["companyName"] as? String) ?? ""
                self.brandsReadyUi = (args["brand"]) as? [String] ?? []
                self.themColorHex = (args["themColorHexIOS"] as? String) ?? ""
                self.setStorePaymentDetailsMode = (args["setStorePaymentDetailsMode"] as? String) ?? ""

                DispatchQueue.main.async {
                    self.openCheckoutUI(checkoutId: self.checkoutid, result1: result)
                }
            } else if self.type  == "CustomUI"{
                 self.brands = (args["brand"] as? String) ?? ""
                 self.number = (args["card_number"] as? String) ?? ""
                 self.holder = (args["holder_name"] as? String) ?? ""
                 self.year = (args["year"] as? String) ?? ""
                 self.month = (args["month"] as? String) ?? ""
                 self.cvv = (args["cvv"] as? String) ?? ""
                 self.setStorePaymentDetailsMode = (args["EnabledTokenization"] as? String) ?? ""
                 
                 // Apple Pay CustomUI parameters
                 if self.brands == "APPLEPAY" {
                     self.applePaybundel = (args["merchantId"] as? String) ?? ""
                     self.countryCode = (args["CountryCode"] as? String) ?? "SA"
                     self.companyName = (args["companyName"] as? String) ?? "Company"
                     self.currencyCode = (args["currencyCode"] as? String) ?? "SAR"
                     if let amountValue = args["amount"] as? Double {
                         self.amount = amountValue
                     }
                 }
                 
                 self.openCustomUI(checkoutId: self.checkoutid, result1: result)
            } else if self.type == "StoredCards" {
                 self.cvv = (args["cvv"] as? String) ?? ""
                 self.tokenID = (args["TokenID"] as? String) ?? ""
                 
                 self.storedCardPayment(checkoutId: self.checkoutid, result1: result)
            }
            else {
                result(FlutterError(code: "1", message: "Method name is not found", details: ""))
                    }

        } else {
                result(FlutterError(code: "1", message: "Method name is not found", details: ""))
            }
        }

    @IBAction func checkoutButtonAction(_ sender: UIButton) {
        // Set a delegate property for the OPPCheckoutProvider instance
        self.checkoutProvider?.delegate = self
    }
 
    // Implement a callback, it will be called after holder text field loses focus or Pay button is pressed
    public func checkoutProvider(
        _ checkoutProvider: OPPCheckoutProvider, validateCardHolder cardHolder: String?
    ) -> Bool {
        guard let cardHolder = cardHolder, !cardHolder.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return false
        }
        
        return true
    }

    private func openCheckoutUI(checkoutId: String,result1: @escaping FlutterResult) {
         if self.mode == "live" {
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
         }else{
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
         }
         
         // Set 3DS Event Listener
         self.provider.threeDSEventListener = self
         
         DispatchQueue.main.async{
             let checkoutSettings = OPPCheckoutSettings()
             checkoutSettings.paymentBrands = self.brandsReadyUi;
             
             if(self.brandsReadyUi.contains("APPLEPAY")){
                     let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: self.applePaybundel, countryCode: self.countryCode)
                     paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: self.companyName, amount: NSDecimalNumber(value: self.amount))]

                     paymentRequest.supportedNetworks = self.convertToPaymentNetworks(self.supportedNetworks)

                     checkoutSettings.applePayPaymentRequest = paymentRequest
             }
             
             checkoutSettings.language = self.lang
             checkoutSettings.shopperResultURL = self.shopperResultURL+"://result"
             
             if self.setStorePaymentDetailsMode=="true"{
                 checkoutSettings.storePaymentDetails = OPPCheckoutStorePaymentDetailsMode.prompt;
             }
             
             self.setThem(checkoutSettings: checkoutSettings, hexColorString: self.themColorHex)
             
             self.checkoutProvider = OPPCheckoutProvider(paymentProvider: self.provider, checkoutID: checkoutId, settings: checkoutSettings)!
             self.checkoutProvider?.delegate = self
             
             self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: {
                 (transaction, error) in
                 
                 if let error = error {
                     result1(FlutterError.init(code: "TRANSACTION_ERROR",message: "Error: " + error.localizedDescription,details: nil))
                     self.Presult = nil
                     return
                 }
                 
                 guard let validTransaction = transaction else {
                     result1(FlutterError.init(code: "TRANSACTION_NIL",message: "Transaction is nil",details: nil))
                     self.Presult = nil
                     return
                 }
                 
                 self.transaction = validTransaction
                if validTransaction.type == .synchronous {
                    self.dismissThreeDSNavigationControllerIfPresented {
                        DispatchQueue.main.async {
                            result1("SYNC")
                            self.Presult = nil
                        }
                    }
                }
                 else if validTransaction.type == .asynchronous {
                     NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                 }
                 else {
                     // result1("error")
                     result1(FlutterError.init(code: "1",message:"Error : operation cancel",details: nil))
                     self.Presult = nil
                     // Executed in case of failure of the transaction for any reason
                     print(self.transaction.debugDescription)
                 }
             }
                                                    , cancelHandler: {
                                                    // result1("error")
                                                     result1(FlutterError.init(code: "1",message: "Error : operation cancel",details: nil))
                                                     self.Presult = nil
                                                        // Executed if the shopper closes the payment page prematurely
                                                        print(self.transaction.debugDescription)
                                                    })
         }
     }

    private func openCustomUI(checkoutId: String,result1: @escaping FlutterResult) {
        if self.mode == "live" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        }else{
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        }
        
        // Set 3DS Event Listener
        self.provider.threeDSEventListener = self

        // Handle Apple Pay CustomUI
        if self.brands == "APPLEPAY" {
            self.openApplePayCustomUI(checkoutId: checkoutId, result1: result1)
            return
        }

        if !OPPCardPaymentParams.isNumberValid(self.number, luhnCheck: true) {
            self.createalart(titletext: "Card Number is Invalid", msgtext: "")
        }
        else  if !OPPCardPaymentParams.isHolderValid(self.holder) {
            self.createalart(titletext: "Card Holder is Invalid", msgtext: "")
        }
        else   if !OPPCardPaymentParams.isCvvValid(self.cvv) {
            self.createalart(titletext: "CVV is Invalid", msgtext: "")
        }
        else  if !OPPCardPaymentParams.isExpiryYearValid(self.year) {
            self.createalart(titletext: "Expiry Year is Invalid", msgtext: "")
        }
        else  if !OPPCardPaymentParams.isExpiryMonthValid(self.month) {
            self.createalart(titletext: "Expiry Month is Invalid", msgtext: "")
        }
        else {
            do {
                let params = try OPPCardPaymentParams(checkoutID: checkoutId, paymentBrand: self.brands, holder: self.holder, number: self.number, expiryMonth: self.month, expiryYear: self.year, cvv: self.cvv)
                
                var isEnabledTokenization:Bool = false;
                if(self.setStorePaymentDetailsMode=="true"){
                    isEnabledTokenization=true;
                }
                params.isTokenizationEnabled=isEnabledTokenization;
                params.shopperResultURL =  self.shopperResultURL+"://result"
                
                self.transaction  = OPPTransaction(paymentParams: params)
                
                self.provider.submitTransaction(self.transaction!) {
                    (transaction, error) in
                    
                    if let error = error {
                        let errorMessage = error.localizedDescription
                        self.createalart(titletext: "Transaction Error", msgtext: errorMessage)
                        return
                    }
                    
                    guard let transaction = self.transaction else {
                        self.createalart(titletext: "Transaction Error", msgtext: "Transaction is nil")
                        return
                    }
                    
                    if transaction.type == .asynchronous {
                        guard let redirectURL = self.transaction?.redirectURL else {
                            self.createalart(titletext: "Transaction Error", msgtext: "Redirect URL is nil")
                            return
                        }
                        
                        self.safariVC = SFSafariViewController(url: redirectURL)
                        self.safariVC?.delegate = self;
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.windows.first?.rootViewController?.present(self.safariVC!, animated: true, completion: nil)
                        }
                    }
                    else if transaction.type == .synchronous {
                        self.dismissThreeDSNavigationControllerIfPresented {
                            result1("SYNC")
                            self.Presult = nil
                        }
                    }
                    else {
                        let errorMessage = error?.localizedDescription ?? "Transaction failed"
                        self.createalart(titletext: "Payment Error", msgtext: errorMessage)
                    }
                }
            }
            catch let error as NSError {
                self.createalart(titletext: error.localizedDescription, msgtext: "")
            }
        }
    }

    private func storedCardPayment(checkoutId: String, result1: @escaping FlutterResult) {
        if self.mode == "live" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        } else {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        }
        
        // Set 3DS Event Listener
        self.provider.threeDSEventListener = self
        
        if !OPPCardPaymentParams.isCvvValid(self.cvv) {
            self.createalart(titletext: "CVV is Invalid", msgtext: "")
            return
        }
        
        do {
            let params = try OPPTokenPaymentParams(checkoutID: checkoutId, tokenID: self.tokenID, cardPaymentBrand: self.brands, cvv: self.cvv)
            params.shopperResultURL = self.shopperResultURL + "://result"
            
            self.transaction = OPPTransaction(paymentParams: params)
            
            self.provider.submitTransaction(self.transaction!) { (transaction, error) in
                if let error = error {
                    let errorMessage = error.localizedDescription
                    self.createalart(titletext: "Transaction Error", msgtext: errorMessage)
                    return
                }
                
                guard let transaction = self.transaction else {
                    self.createalart(titletext: "Transaction Error", msgtext: "Transaction is nil")
                    return
                }
                
                if transaction.type == .asynchronous {
                    guard let redirectURL = self.transaction?.redirectURL else {
                        self.createalart(titletext: "Transaction Error", msgtext: "Redirect URL is nil")
                        return
                    }
                    
                    self.safariVC = SFSafariViewController(url: redirectURL)
                    self.safariVC?.delegate = self
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.windows.first?.rootViewController?.present(self.safariVC!, animated: true, completion: nil)
                    }
                } else if transaction.type == .synchronous {
                    self.dismissThreeDSNavigationControllerIfPresented {
                        result1("SYNC")
                        self.Presult = nil
                    }
                } else {
                    let errorMessage = error?.localizedDescription ?? "Transaction failed"
                    self.createalart(titletext: "Payment Error", msgtext: errorMessage)
                }
            }
        } catch let error as NSError {
            self.createalart(titletext: "Token Payment Error", msgtext: error.localizedDescription)
        }
    }

    private func openApplePayCustomUI(checkoutId: String, result1: @escaping FlutterResult) {
        let request = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: self.applePaybundel, countryCode: self.countryCode)
        request.currencyCode = self.currencyCode
        
        // Format amount to 2 decimal places
        let formattedAmount = Double(String(format: "%.2f", self.amount))!
        
        // Create payment summary items
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: self.companyName, amount: NSDecimalNumber(value: formattedAmount))]
        
        request.supportedNetworks = self.convertToPaymentNetworks(self.supportedNetworks)
        
        // Check if Apple Pay is supported and present the payment authorization view controller
        if OPPPaymentProvider.canSubmitPaymentRequest(request) {
            if let applePayViewController = PKPaymentAuthorizationViewController(paymentRequest: request) {
                applePayViewController.delegate = self
                
                DispatchQueue.main.async {
                    UIApplication.shared.windows.first?.rootViewController?.present(applePayViewController, animated: true, completion: nil)
                }
            } else {
                self.createalart(titletext: "Apple Pay Error", msgtext: "Apple Pay not supported on this device")
            }
        } else {
            self.createalart(titletext: "Apple Pay Error", msgtext: "Apple Pay not available")
        }
    }

    @objc func didReceiveAsynchronousPaymentCallback(result: @escaping FlutterResult) {
        // Guard against double callbacks if 3DS was manually dismissed
        guard self.isThreeDSProcessActive || self.presentedThreeDSNavigationController != nil else {
            return
        }
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        
        // First dismiss any presented 3DS navigation controller
        if let threeDSNavController = self.presentedThreeDSNavigationController {
            threeDSNavController.dismiss(animated: true) {
                self.presentedThreeDSNavigationController = nil
                self.isThreeDSProcessActive = false
                self.continuePaymentCallback(result: result)
            }
        } else {
            self.continuePaymentCallback(result: result)
        }
    }
    
    private func continuePaymentCallback(result: @escaping FlutterResult) {
        if self.type == "ReadyUI" || self.type=="APPLEPAY"||self.type=="StoredCards"{
            self.checkoutProvider?.dismissCheckout(animated: true) {
                DispatchQueue.main.async {
                    result("success")
                    self.Presult = nil
                }
            }
        }
        else {
            self.safariVC?.dismiss(animated: true) {
                DispatchQueue.main.async {
                    result("success")
                    self.Presult = nil
                }
            }
        }
    }
    
    private func dismissThreeDSNavigationControllerIfPresented(completion: @escaping () -> Void) {
        if let threeDSNavController = self.presentedThreeDSNavigationController {
            DispatchQueue.main.async {
                threeDSNavController.dismiss(animated: true) {
                    self.presentedThreeDSNavigationController = nil
                    self.isThreeDSProcessActive = false
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handler:Bool = false
        if url.scheme?.caseInsensitiveCompare( self.shopperResultURL) == .orderedSame {
            didReceiveAsynchronousPaymentCallback(result: self.Presult!)
            handler = true
        }

        return handler
    }

    func createalart(titletext:String,msgtext:String){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: titletext, message: msgtext, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default,handler: {
                (action) in 
                alertController.dismiss(animated: true, completion: nil)
            }))
            
            UIApplication.shared.delegate?.window??.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - PKPaymentAuthorizationViewControllerDelegate
    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true) {
            // If Presult is still available, user cancelled before payment completion
            if let result = self.Presult {
                result(FlutterError(code: "PAYMENT_CANCELLED", message: "Apple Pay was cancelled by user", details: nil))
                self.Presult = nil
            }
        }
    }
    
    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        do {
            let params = try OPPApplePayPaymentParams(checkoutID: self.checkoutid, tokenData: payment.token.paymentData)
            params.shopperResultURL = self.shopperResultURL + "://result"
            
            self.transaction = OPPTransaction(paymentParams: params)
            
            self.provider.submitTransaction(self.transaction!, completionHandler: { (transaction, error) in
                if let error = error {
                    completion(.failure)
                    DispatchQueue.main.async {
                        self.createalart(titletext: "Apple Pay Error", msgtext: error.localizedDescription)
                    }
                } else {
                    completion(.success)
                    
                    if transaction.type == .synchronous {
                        self.dismissThreeDSNavigationControllerIfPresented {
                            DispatchQueue.main.async {
                                self.Presult!("SYNC")
                                self.Presult = nil
                            }
                        }
                    } else {
                        self.dismissThreeDSNavigationControllerIfPresented {
                            DispatchQueue.main.async {
                                self.Presult!("success")
                                self.Presult = nil
                            }
                        }
                    }
                }
            })
        } catch let error as NSError {
            completion(.failure)
            DispatchQueue.main.async {
                self.createalart(titletext: "Apple Pay Error", msgtext: "Failed to create payment parameters")
            }
        }
    }
    
    func decimal(with string: String) -> NSDecimalNumber {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        let result = formatter.number(from: string) as? NSDecimalNumber ?? 0
        return result
    }

    func setThem( checkoutSettings :OPPCheckoutSettings,hexColorString :String){
        // General colors of the checkout UI
        checkoutSettings.theme.confirmationButtonColor = UIColor(red:0,green:0.75,blue:0,alpha:1);
        checkoutSettings.theme.navigationBarBackgroundColor = UIColor(hexString:hexColorString);
        checkoutSettings.theme.cellHighlightedBackgroundColor = UIColor(hexString:hexColorString);
        checkoutSettings.theme.accentColor = UIColor(hexString:hexColorString);
    }
     
    // MARK: - 3DS Event Listener Delegate Methods
    public func onThreeDSChallengeRequired(completion: @escaping (UINavigationController) -> Void) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                if let navigationController = rootViewController as? UINavigationController {
                    self.isThreeDSProcessActive = true
                    completion(navigationController)
                } else {
                    // Create a new navigation controller with a placeholder view controller
                    let placeholderViewController = UIViewController()
                    placeholderViewController.view.backgroundColor = UIColor.white
                    
                    let navigationController = UINavigationController(rootViewController: placeholderViewController)
                    
                    // Set up dismissal detection
                    if let presentationController = navigationController.presentationController {
                        presentationController.delegate = self
                    }
                    
                    // Present the navigation controller
                    rootViewController.present(navigationController, animated: true) {
                        // Store reference to dismiss later
                        self.presentedThreeDSNavigationController = navigationController
                        self.isThreeDSProcessActive = true
                        completion(navigationController)
                    }
                }
            } else {
                // Create a standalone navigation controller
                let placeholderViewController = UIViewController()
                placeholderViewController.view.backgroundColor = UIColor.white
                let navigationController = UINavigationController(rootViewController: placeholderViewController)
                self.isThreeDSProcessActive = true
                completion(navigationController)
            }
        }
    }

    public func onThreeDSConfigRequired(completion: @escaping (OPPThreeDSConfig) -> Void) {
        let config = OPPThreeDSConfig()
        config.appBundleID = Bundle.main.bundleIdentifier ?? "com.excprotection.payment"
        
        completion(config)
    }
    
    // MARK: - SFSafariViewControllerDelegate
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true) {
            // If Presult is still available, user cancelled before payment completion
            if let result = self.Presult {
                result(FlutterError(code: "PAYMENT_CANCELLED", message: "Payment was cancelled by user", details: nil))
                self.Presult = nil
            }
        }
    }
    
    public func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
    }
    
    // MARK: - UIAdaptivePresentationControllerDelegate
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        // Check if this is our 3DS navigation controller
        if let navigationController = presentationController.presentedViewController as? UINavigationController,
           navigationController == self.presentedThreeDSNavigationController {
            self.handle3DSManualDismissal()
        }
    }
    
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true // Allow dismissal
    }
    
    private func handle3DSManualDismissal() {
        // Clean up 3DS state
        self.presentedThreeDSNavigationController = nil
        
        // Only handle if 3DS process is active
        if self.isThreeDSProcessActive {
            self.isThreeDSProcessActive = false
            
            // Remove any notification observers
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            
            // Return error to Flutter
            DispatchQueue.main.async {
                self.Presult?(FlutterError(code: "3DS_CANCELLED", message: "3DS Challenge was cancelled by user", details: nil))
                self.Presult = nil
            }
        }
    }

    /// Converts an array of network name strings to PKPaymentNetwork objects
    /// Handles edge cases and provides fallbacks for invalid network names
    private func convertToPaymentNetworks(_ networkStrings: [String]?) -> [PKPaymentNetwork] {
        guard let networks = networkStrings, !networks.isEmpty else {
            // Return default networks based on iOS version if no networks specified
            if #available(iOS 12.1.1, *) {
                return [PKPaymentNetwork.mada, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
            } else {
                return [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
            }
        }

        var paymentNetworks: [PKPaymentNetwork] = []

        for networkString in networks {
            let lowercasedNetwork = networkString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

            switch lowercasedNetwork {
            case "visa":
                paymentNetworks.append(PKPaymentNetwork.visa)
            case "mastercard", "master card":
                paymentNetworks.append(PKPaymentNetwork.masterCard)
            case "mada":
                if #available(iOS 12.1.1, *) {
                    paymentNetworks.append(PKPaymentNetwork.mada)
                }
                // Skip MADA on older iOS versions

            default:
                print("Warning: Unsupported payment network '\(networkString)'. Skipping.")
                // Skip invalid network names
            }
        }

        // Ensure we have at least one valid network
        if paymentNetworks.isEmpty {
            print("Warning: No valid payment networks found. Using defaults.")
            if #available(iOS 12.1.1, *) {
                return [PKPaymentNetwork.mada, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
            } else {
                return [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
            }
        }

        return paymentNetworks
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}