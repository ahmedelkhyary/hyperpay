import '../flutter_hyperpay.dart';

/// ReadyUI class holds all the necessary data related to the ReadyUI payment method
/// which is used in PaymentConst. It is required to provide checkoutId when initializing the class.
/// Also, we can provide brandName and themColorHexIOS as optional values.
/// setStorePaymentDetailsMode is set to false by default.
class ReadyUI {
  /// initializes a variable named paymentType with the value PaymentConst.customUi.
  String paymentType = PaymentConst.readyUi;

  /// declares a string variable named checkoutId without assigning it an initial value.
  String checkoutId;
  bool setStorePaymentDetailsMode;

  ///  brandName variable could be used to store the name of the brand or company
  List<String> brandsName;

  /// merchantId is a unique identifier associated with your Apple Developer account and is used to enable Apple Pay in your iOS app.
  String merchantIdApplePayIOS;

  ///  countryCode typically refers to the two-letter country code associated with the region or country where your business or app is based. It is used as part of the configuration for Apple Pay.
  String countryCodeApplePayIOS;

  /// companyName typically refers to the legal name of your business or organization that is associated with your Apple Pay configuration. This information is used when setting up your Merchant ID for Apple Pay.
  String companyNameApplePayIOS = "";

  /// themColorHexIOS is likely intended to represent the hexadecimal color code for the theme color you want to use in your iOS app. The term may contain a typo; it's more commonly referred to as themeColorHexIOS.
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
