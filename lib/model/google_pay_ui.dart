import '../flutter_hyperpay.dart';

/// GooglePayUI class holds all the necessary data related to the Google Pay payment method.
/// It is required to provide checkoutId and googlePayMerchantId when initializing the class.
/// This is Android-only as Google Pay is not available on iOS.
class GooglePayUI {
  /// Payment type identifier
  String paymentType = PaymentConst.googlePay;

  /// Checkout ID from HyperPay backend
  String checkoutId;

  /// Google Pay Merchant ID from Google Pay Business Console
  String googlePayMerchantId;

  /// Gateway merchant ID (HyperPay Entity ID)
  String gatewayMerchantId;

  /// Country code (e.g., "SA" for Saudi Arabia)
  String countryCode;

  /// Currency code (e.g., "SAR")
  String currencyCode;

  /// Total amount for the transaction
  String amount;

  /// Allowed card networks (e.g., ["VISA", "MASTERCARD"])
  List<String> allowedCardNetworks;

  /// Allowed card auth methods (e.g., ["PAN_ONLY", "CRYPTOGRAM_3DS"])
  List<String> allowedCardAuthMethods;

  GooglePayUI({
    required this.checkoutId,
    required this.googlePayMerchantId,
    required this.gatewayMerchantId,
    required this.countryCode,
    required this.currencyCode,
    required this.amount,
    this.allowedCardNetworks = const ["VISA", "MASTERCARD", "MADA"],
    this.allowedCardAuthMethods = const ["PAN_ONLY", "CRYPTOGRAM_3DS"],
  });
}
