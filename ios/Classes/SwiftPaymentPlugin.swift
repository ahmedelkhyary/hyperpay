import Flutter
import UIKit
import SafariServices

public class SwiftPaymentPlugin: NSObject,FlutterPlugin ,SFSafariViewControllerDelegate, OPPCheckoutProviderDelegate  {
    var type:String = "";
    var mode:String = "";
    var checkoutid:String = "";
    var brand:String = "";
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
    var themColorHex:String = "#1298AD";
    var safariVC: SFSafariViewController?
    var transaction: OPPTransaction?
    var provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    var checkoutProvider: OPPCheckoutProvider?
    var Presult:FlutterResult?
    // var enabledTokenization:String =  "";



  public static func register(with registrar: FlutterPluginRegistrar) {
    let flutterChannel:String = "Hyperpay.demo.fultter/channel";
    let channel = FlutterMethodChannel(name: flutterChannel, binaryMessenger: registrar.messenger())
    let instance = SwiftPaymentPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
     
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.Presult = result
        
        if call.method == "gethyperpayresponse"{
            let args = call.arguments as? Dictionary<String,Any>
            self.type = (args!["type"] as? String)!
            self.brand = (args!["brand"] as? String)!
            self.mode = (args!["mode"] as? String)!
            self.checkoutid = (args!["checkoutid"] as? String)!
            self.shopperResultURL = (args!["ShopperResultUrl"] as? String)!
            self.lang=(args!["lang"] as? String)!
            
            
            if self.type == "ReadyUI" {
                self.setStorePaymentDetailsMode=(args!["setStorePaymentDetailsMode"] as? String )!
                
                DispatchQueue.main.async {
                    self.openCheckoutUI(checkoutId: self.checkoutid, result1: result)
                }
                
            }
            
            else if self.type=="StoredCards"{
                self.cvv = (args!["cvv"] as? String)!
                self.tokenID=(args!["TokenID"] as? String)!
                storedCards(checkoutId: self.checkoutid, result1: result)
            }else if self.type=="APPLEPAY"{
                self.applePaybundel=(args!["ApplePayBundel"] as? String)!
                self.countryCode=(args!["CountryCode"] as? String)!
                self.currencyCode=(args!["CurrencyCode"] as? String)!
                applepay(checkoutId: self.checkoutid, result1: result)
            }
            else {
                if let brand = (args!["brand"] as? String) {
                    self.brand = brand
                    self.number = (args!["card_number"] as? String)!
                    self.holder = (args!["holder_name"] as? String)!
                    self.year = (args!["year"] as? String)!
                    self.month = (args!["month"] as? String)!
                    self.cvv = (args!["cvv"] as? String)!
                    self.pMadaVExp = (args!["MadaRegexV"] as? String)!
                    self.prMadaMExp = (args!["MadaRegexM"] as? String)!
                }
                if let amount = (args!["Amount"] as? Double) {
                    self.amount = amount
                }
                if let STCPAY = (args!["STCPAY"] as? String) {
                    self.STCPAY = STCPAY
                }
                openCustomUI(checkoutId: self.checkoutid, result1: result)
            }
            
            
        }else {
                result(FlutterError(code: "1", message: "Method name is not found", details: ""))
            }
        }
    
    
    private func openCheckoutUI(checkoutId: String,result1: @escaping FlutterResult) {
         
         if self.mode == "live" {
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
         }else{
             self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
         }
         DispatchQueue.main.async{
             let checkoutSettings = OPPCheckoutSettings()
             if self.brand == "MADA" {
                 checkoutSettings.paymentBrands = ["MADA"]
             }
             else if self.brand == "VISA" {
                 checkoutSettings.paymentBrands = ["VISA"]
             }else if self.brand=="MASTER"{
                 checkoutSettings.paymentBrands = ["MASTER"]
             } else if self.brand=="STC_PAY"{
                 checkoutSettings.paymentBrands = ["STC_PAY"]
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
    
    
    
    private func applepay(checkoutId: String,result1: @escaping FlutterResult) {
           
           if self.mode == "live" {
               self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
           }else{
               self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
               
           }
           DispatchQueue.main.async{
               let checkoutSettings = OPPCheckoutSettings()
               if self.brand == "MADA" {
                   checkoutSettings.paymentBrands = ["MADA"]
               }
               else if self.brand == "VISA" {
                   checkoutSettings.paymentBrands = ["VISA"]
               }else if self.brand=="MASTER"{
                   checkoutSettings.paymentBrands = ["MASTER"]
               } else if self.brand=="STC_PAY"{
                   checkoutSettings.paymentBrands = ["STC_PAY"]
               }
               else if self.brand == "APPLEPAY" {
                   let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: self.applePaybundel, countryCode: self.countryCode)
                   if #available(iOS 12.1.1, *) {
                       paymentRequest.supportedNetworks = [ PKPaymentNetwork.mada,PKPaymentNetwork.visa,
                                                           PKPaymentNetwork.masterCard ]
                   }
                   else {
                       // Fallback on earlier versions
                       paymentRequest.supportedNetworks = [ PKPaymentNetwork.visa,
                                                           PKPaymentNetwork.masterCard ]
                   }
                   checkoutSettings.applePayPaymentRequest = paymentRequest
                   checkoutSettings.paymentBrands = ["APPLEPAY"]
                
               }
               self.setThem(checkoutSettings: checkoutSettings, hexColorString: self.themColorHex)
               checkoutSettings.language = self.lang
               // Set available payment brands for your shop
               checkoutSettings.shopperResultURL = self.shopperResultURL+"://result"
          
             
               self.checkoutProvider = OPPCheckoutProvider(paymentProvider: self.provider, checkoutID: checkoutId, settings: checkoutSettings)!
               self.checkoutProvider?.delegate = self
               self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: {
                   (transaction, error) in
                   guard let transaction = transaction else {
                       // Handle invalid transaction, check error
                       print(error.debugDescription)
                       result1(FlutterError.init(code: "1",message: "Error: " + error.debugDescription,details: nil))
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
                       // Executed in case of failure of the transaction for any reason
                       result1(FlutterError.init(code: "1",message: "Error: " + self.transaction.debugDescription,details: nil))
                       print(self.transaction.debugDescription)
                   }
               }
                                                      , cancelHandler: {
                                                          // Executed if the shopper closes the payment page prematurely
                                                          print(self.transaction.debugDescription)
                                                      })
           }

       }
       
       private func storedCards(checkoutId: String,result1: @escaping FlutterResult) {
           if self.mode == "live" {
               self.provider = OPPPaymentProvider(mode: OPPProviderMode.live)
           }else{
               self.provider = OPPPaymentProvider(mode: OPPProviderMode.test)
               
           }
           do {
               let params = try OPPTokenPaymentParams(checkoutID: self.checkoutid, tokenID: self.tokenID, cardPaymentBrand: self.brand, cvv:self.cvv)
               params.shopperResultURL =  self.shopperResultURL+"://result"
               self.transaction  = OPPTransaction(paymentParams: params)
               self.provider.submitTransaction(self.transaction!) {
                   (transaction, error) in
                   guard let transaction = self.transaction else {
                       // Handle invalid transaction, check error
                       self.createalart(titletext: error.debugDescription , msgtext: "")
                       return
                   }
                   if transaction.type == .asynchronous {
                       self.safariVC = SFSafariViewController(url: self.transaction!.redirectURL!)
                       self.safariVC?.delegate = self;
                       //    self.present(self.safariVC!, animated: true, completion: nil)
                       UIApplication.shared.delegate?.window??.rootViewController?.present(self.safariVC!, animated: true, completion: nil)
                   }
                   else if transaction.type == .synchronous {
                       // Send request to your server to obtain transaction status
                       result1("success")
                   }
                   else {
                       // Handle the error
                       result1(FlutterError(code: "UNAVAILABLE Else",
                       message: error.debugDescription,
                       details: nil))
                   }
               }
               // Set shopper result URL
               //    params.shopperResultURL = "com.companyname.appname.payments://result"
           }
           catch let error as NSError {
               // See error.code (OPPErrorCode) and error.localizedDescription to identify the reason of failure
               self.createalart(titletext: error.localizedDescription, msgtext: "")
           }

       }

private func openCustomUI(checkoutId: String,result1: @escaping FlutterResult) {}

       
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
           print("urlscheme:" + (url.scheme)!)
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
       func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
           controller.dismiss(animated: true, completion: nil)
       }
       func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
           if let params = try? OPPApplePayPaymentParams(checkoutID: self.checkoutid, tokenData: payment.token.paymentData) as OPPApplePayPaymentParams? {
               self.transaction  = OPPTransaction(paymentParams: params)
               self.provider.submitTransaction(OPPTransaction(paymentParams: params), completionHandler: {
                   (transaction, error) in
                   if (error != nil) {
                       // see code attribute (OPPErrorCode) and NSLocalizedDescription to identify the reason of failure.
                       self.createalart(titletext: "APPLEPAY Error", msgtext: "")
                   }
                   else {
                       // send request to your server to obtain transaction status.
                       completion(.success)
                       self.Presult!("success")
                   }
               })
           }

       }
       func decimal(with string: String) -> NSDecimalNumber {
           //  let formatter = NumberFormatter()
           let formatter = NumberFormatter()
           formatter.minimumFractionDigits = 2
           return formatter.number(from: string) as? NSDecimalNumber ?? 0
       }
    
    func setThem( checkoutSettings :OPPCheckoutSettings,hexColorString :String){
         // General colors of the checkout UI
         checkoutSettings.theme.confirmationButtonColor = UIColor(hexString:hexColorString);
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
