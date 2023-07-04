import '../flutter_hyperpay.dart';

/// ReadyUI class holds all the necessary data related to the ReadyUI payment method
/// which is used in PaymentConst. It is required to provide checkoutId when initializing the class.
/// Also, we can provide brandName and themColorHexIOS as optional values.
/// setStorePaymentDetailsMode is set to false by default.
class ReadyUI {
  String paymentType = PaymentConst.readyUi;
  String checkoutId;
  bool setStorePaymentDetailsMode;
  List<String> brandsName;
  String merchantIdApplePayIOS;
  String countryCodeApplePayIOS;
  String companyNameApplePayIOS = "";
  String themColorHexIOS;

  ReadyUI({
    required this.checkoutId,
    required this.brandsName,
    this.merchantIdApplePayIOS = "",
    this.countryCodeApplePayIOS = "",
    this.companyNameApplePayIOS = "",
    this.themColorHexIOS = "",
    this.setStorePaymentDetailsMode = false,
  });
}
