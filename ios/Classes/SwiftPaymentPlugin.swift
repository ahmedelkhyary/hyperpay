import Flutter
import UIKit
import SafariServices
import PassKit

public class SwiftPaymentPlugin: NSObject,FlutterPlugin ,SFSafariViewControllerDelegate, OPPCheckoutProviderDelegate, PKPaymentAuthorizationViewControllerDelegate, OPPThreeDSEventListener   {
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
    var safariVC: SFSafariViewController?
    var transaction: OPPTransaction?
    var provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    var checkoutProvider: OPPCheckoutProvider?
    var Presult:FlutterResult?
    var window: UIWindow?


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
            let args = call.arguments as? Dictionary<String,Any>
            self.type = (args!["type"] as? String)!
            self.mode = (args!["mode"] as? String)!
            self.checkoutid = (args!["checkoutid"] as? String)!
            self.shopperResultURL = (args!["ShopperResultUrl"] as? String)!
            self.lang=(args!["lang"] as? String)!

            if self.type == "ReadyUI" {
                self.brandsReadyUi = (args!["brand"]) as! [String]
                
                if self.brandsReadyUi.count == 1 && self.brandsReadyUi.first == "APPLEPAY" {
                    self.applePaybundel = (args!["merchantId"] as? String)!
                    self.countryCode = (args!["CountryCode"] as? String)!
                    self.companyName = (args!["companyName"] as? String)!
                    self.amount = (args!["amount"] as? Double)!

                    self.currencyCode = (args!["currencyCode"] as? String) ?? "SAR"

                    DispatchQueue.main.async {
                        self.openApplePay(result1: result)
                    }
                } else {
                    self.applePaybundel = (args!["merchantId"] as? String)!
                    self.countryCode = (args!["CountryCode"] as? String)!
                    self.companyName = (args!["companyName"] as? String)!
                    self.themColorHex = (args!["themColorHexIOS"] as? String)!
                    self.setStorePaymentDetailsMode = (args!["setStorePaymentDetailsMode"] as? String )!

                    DispatchQueue.main.async {
                        self.openCheckoutUI(checkoutId: self.checkoutid, result1: result)
                    }
                }
            } else if self.type  == "CustomUI"{

                 self.brands = (args!["brand"] as? String)!
                 self.number = (args!["card_number"] as? String)!
                 self.holder = (args!["holder_name"] as? String)!
                 self.year = (args!["year"] as? String)!
                 self.month = (args!["month"] as? String)!
                 self.cvv = (args!["cvv"] as? String)!
                 self.setStorePaymentDetailsMode = (args!["EnabledTokenization"] as? String)!
                 self.openCustomUI(checkoutId: self.checkoutid, result1: result)
            } else if self.type  == "StoredCards"{
                self.tokenID = (args!["TokenID"] as? String)!
                self.cvv = (args!["cvv"] as? String)!
                self.openStoredCardPayment(checkoutId: self.checkoutid, result1: result)
           } else {
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
        // return `true` if the card holder is valid, otherwise `false`
    }


    private func openCheckoutUI(checkoutId: String,result1: @escaping FlutterResult) {

         if self.mode == "live" {
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
         }else{
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
         }
         DispatchQueue.main.async{

             let checkoutSettings = OPPCheckoutSettings()
             checkoutSettings.paymentBrands = self.brandsReadyUi;
             if(self.brandsReadyUi.contains("APPLEPAY")){

                     let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: self.applePaybundel, countryCode: self.countryCode)
                     paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: self.companyName, amount: NSDecimalNumber(value: self.amount))]

                     if #available(iOS 12.1.1, *) {
                         paymentRequest.supportedNetworks = [ PKPaymentNetwork.mada,PKPaymentNetwork.visa, PKPaymentNetwork.masterCard ]
                     }
                     else {
                         // Fallback on earlier versions
                         paymentRequest.supportedNetworks = [ PKPaymentNetwork.visa, PKPaymentNetwork.masterCard ]
                     }
                     checkoutSettings.applePayPaymentRequest = paymentRequest
                    // checkoutSettings.paymentBrands = ["APPLEPAY"]
             }
             checkoutSettings.language = self.lang
             // Set available payment brands for your shop
             checkoutSettings.shopperResultURL = self.shopperResultURL+"://result"
             if self.setStorePaymentDetailsMode=="true"{
                 checkoutSettings.storePaymentDetails = OPPCheckoutStorePaymentDetailsMode.prompt;
             }
             self.setThem(checkoutSettings: checkoutSettings, hexColorString: self.themColorHex)
             self.checkoutProvider = OPPCheckoutProvider(paymentProvider: self.provider, checkoutID: checkoutId, settings: checkoutSettings)!
             self.checkoutProvider?.delegate = self
             self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: {
                 (transaction, error) in
                 guard let transaction = transaction else {
                     // Handle invalid transaction, check error
                     // result1("error")
                     result1(FlutterError.init(code: "1",message: "Error: " + self.transaction.debugDescription,details: nil))
                     return
                 }
                 self.transaction = transaction
                 if transaction.type == .synchronous {
                     // If a transaction is synchronous, just request the payment status
                     // You can use transaction.resourcePath or just checkout ID to do it
                     DispatchQueue.main.async {
                         result1("SYNC")
                     }
                 }
                 else if transaction.type == .asynchronous {
                     NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                 }
                 else {
                     // result1("error")
                     result1(FlutterError.init(code: "1",message:"Error : operation cancel",details: nil))
                     // Executed in case of failure of the transaction for any reason
                     print(self.transaction.debugDescription)
                 }
             }
                                                    , cancelHandler: {
                                                    // result1("error")
                                                     result1(FlutterError.init(code: "1",message: "Error : operation cancel",details: nil))
                                                        // Executed if the shopper closes the payment page prematurely
                                                        print(self.transaction.debugDescription)
                                                    })
         }

     }

    private func openStoredCardPayment(checkoutId: String, result1: @escaping FlutterResult) {

        if self.mode == "live" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        }else{
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        }

             if !OPPCardPaymentParams.isCvvValid(self.cvv) {
                self.createalart(titletext: "CVV is Invalid", msgtext: "")
            }
            else {
                do {
                    let params = try OPPTokenPaymentParams(checkoutID: checkoutId, tokenID: self.tokenID, cardPaymentBrand: self.brands, cvv: self.cvv)
                    params.shopperResultURL =  self.shopperResultURL+"://result"
                    self.transaction  = OPPTransaction(paymentParams: params)

                    self.provider.submitTransaction(self.transaction!) {
                        (transaction, error) in
                        guard let transaction = self.transaction else {
                            self.createalart(titletext: "error", msgtext: "Plesae try again")
                            return
                        }
                        if transaction.type == .asynchronous {
                            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                            self.safariVC = SFSafariViewController(url: self.transaction!.redirectURL!)
                            self.safariVC?.delegate = self;
                            self.safariVC?.dismiss(animated: true) {
                                DispatchQueue.main.async {
                                    self.Presult?("success")
                                }
                            }
                        }
                        else if transaction.type == .synchronous {
                            result1("SYNC")
                        }
                        else {
                            self.createalart(titletext: "error", msgtext: "Plesae try again")
                        }
                    }
                }
                catch let error as NSError {
                    self.createalart(titletext: error.localizedDescription, msgtext: "")
                }
            }

     }

    private func openApplePay(result1: @escaping FlutterResult) {
        if self.mode == "live" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        } else {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
        }
        
        let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: self.applePaybundel, countryCode: self.countryCode)
        paymentRequest.currencyCode = self.currencyCode
        paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: self.companyName, amount: NSDecimalNumber(value: self.amount))]
        
        if #available(iOS 12.1.1, *) {
            paymentRequest.supportedNetworks = [.mada, .visa, .masterCard]
        } else {
            paymentRequest.supportedNetworks = [.visa, .masterCard]
        }
        
        if OPPPaymentProvider.canSubmitPaymentRequest(paymentRequest) {
            if let vc = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) {
                vc.delegate = self
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    rootViewController.present(vc, animated: true, completion: nil)
                }
            } else {
                NSLog("Apple Pay not supported.")
            }
        } else {
            NSLog("Unable to submit payment request. Apple Pay might not be set up correctly.")
        }
    }


    private func openCustomUI(checkoutId: String,result1: @escaping FlutterResult) {

        if self.mode == "live" {
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        }else{
            self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
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
                    //set tokenization
                    params.shopperResultURL =  self.shopperResultURL+"://result"
                    
                    self.provider.threeDSEventListener = self
                    self.transaction  = OPPTransaction(paymentParams: params)
                    self.provider.submitTransaction(self.transaction!) {
                        (transaction, error) in
                        guard let transaction = self.transaction else {
                            // Handle invalid transaction, check error
                            self.createalart(titletext: "error", msgtext: "Plesae try again")
                            return
                        }
                        if transaction.type == .asynchronous {
                            self.safariVC = SFSafariViewController(url: self.transaction!.redirectURL!)
                            self.safariVC?.delegate = self;
                            //    self.present(self.safariVC!, animated: true, completion: nil)
                            UIApplication.shared.windows.first?.rootViewController?.present(self.safariVC!, animated: true, completion: nil)
                        }
                        else if transaction.type == .synchronous {
                            // Send request to your server to obtain transaction status
                            result1("success")
                        }
                        else {
                            // Handle the error
                            self.createalart(titletext: "error", msgtext: "Plesae try again")
                        }
                    }
                    // Set shopper result URL
                    //    params.shopperResultURL = "com.companyname.appname.payments://result"
                }
                catch let error as NSError {
                    self.createalart(titletext: error.localizedDescription, msgtext: "")
                }
            }
    }

       @objc func didReceiveAsynchronousPaymentCallback(result: @escaping FlutterResult) {
           NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
           if self.type == "ReadyUI" || self.type=="APPLEPAY"||self.type=="StoredCards"{
               self.checkoutProvider?.dismissCheckout(animated: true) {
                   DispatchQueue.main.async {
                       result("success")
                   }
               }
           }

           else {
               self.safariVC?.dismiss(animated: true) {
                   DispatchQueue.main.async {
                       result("success")
                   }
               }
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
               let alertController = UIAlertController(title: titletext, message:
                                                       msgtext, preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default,handler: {
                   (action) in alertController.dismiss(animated: true, completion: nil)
               }))
               //  alertController.view.tintColor = UIColor.orange
               UIApplication.shared.delegate?.window??.rootViewController?.present(alertController, animated: true, completion: nil)
           }

       }

    // --- THIS IS THE FINAL, FULLY CORRECTED METHOD ---
    // --- Replace your old method with this one ---

    public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        // First, check if you can create the payment parameters
        guard let params = try? OPPApplePayPaymentParams(checkoutID: self.checkoutid, tokenData: payment.token.paymentData) else {
            NSLog("Error: Failed to create OPPApplePayPaymentParams.")
            self.Presult?(FlutterError(code: "APPLEPAY_INIT_FAILED", message: "Failed to initialize Apple Pay parameters.", details: nil))
            completion(.failure)
            return
        }

        params.shopperResultURL = self.shopperResultURL + "://result"
        
        // Submit the transaction to HyperPay
        self.provider.submitTransaction(OPPTransaction(paymentParams: params)) { (transaction, error) in
            
            // --- FIX ---
            // The 'guard let transaction = transaction' block has been removed.
            // We can use the 'transaction' parameter directly.
            
            if transaction.type == .synchronous {
                // For synchronous transactions, the 'error' object tells us the result.
                if error == nil {
                    // NO error means the payment was successful.
                    NSLog("Payment successful (Synchronous)")
                    self.Presult?("success")
                    completion(.success)
                } else {
                    // An error object exists, so the payment failed.
                    let errorMessage = error?.localizedDescription ?? "Payment was declined"
                    NSLog("Payment failed (Synchronous). Details: \(errorMessage)")
                    self.Presult?(FlutterError(code: "PAYMENT_FAILED", message: errorMessage, details: nil))
                    completion(.failure)
                }
            } else if transaction.type == .asynchronous {
                // Asynchronous flow (e.g. 3D Secure) is handled by redirects.
                // The 'error' object here is usually nil unless there's a setup issue.
                // If an error does exist here, it's a critical failure.
                if let asyncError = error {
                     let errorMessage = asyncError.localizedDescription
                     NSLog("Asynchronous flow setup failed. Details: \(errorMessage)")
                     self.Presult?(FlutterError(code: "ASYNC_SETUP_FAILED", message: errorMessage, details: nil))
                     completion(.failure)
                     return
                }
                
                NSLog("Payment is pending (Asynchronous). Waiting for redirect via notification.")
                NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                
                // IMPORTANT: We do NOT call completion() here.
                // The Apple Pay sheet will wait for the final status from the async callback.
            } else {
                // Handle any other unexpected cases as failures.
                let errorMessage = error?.localizedDescription ?? "Unknown transaction type or error."
                NSLog("Payment failed (Unknown State). Details: \(errorMessage)")
                self.Presult?(FlutterError(code: "UNKNOWN_STATE", message: errorMessage, details: nil))
                completion(.failure)
            }
        }
    }

    public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    public func onThreeDSChallengeRequired(redirectURL: String, completion: @escaping (UINavigationController) -> Void) {
        DispatchQueue.main.async {
            guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else {
                print("FATAL ERROR: Could not find a UINavigationController as the root view controller. Check your AppDelegate setup.")
                return
            }
            completion(navController)
        }
    }
        public func onThreeDSConfigRequired(completion: @escaping (OPPThreeDSConfig) -> Void) {
            let config = OPPThreeDSConfig()
            completion(config)
        }
       func decimal(with string: String) -> NSDecimalNumber {
           //  let formatter = NumberFormatter()
           let formatter = NumberFormatter()
           formatter.minimumFractionDigits = 2
           return formatter.number(from: string) as? NSDecimalNumber ?? 0
       }

    func setThem( checkoutSettings :OPPCheckoutSettings,hexColorString :String){
         // General colors of the checkout UI
         checkoutSettings.theme.confirmationButtonColor = UIColor(red:0,green:0.75,blue:0,alpha:1);
         checkoutSettings.theme.navigationBarBackgroundColor = UIColor(hexString:hexColorString);
         checkoutSettings.theme.cellHighlightedBackgroundColor = UIColor(hexString:hexColorString);
         checkoutSettings.theme.accentColor = UIColor(hexString:hexColorString);
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
