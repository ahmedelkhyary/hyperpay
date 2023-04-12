part of 'flutter_hyperpay.dart';

class ApplePay {
  String applePayBundel;
  String countryCode;
  String currencyCode;
  String checkoutId;
  String? themColorHexIOS;

  ApplePay(
      {required this.applePayBundel,
      required this.checkoutId,
      required this.countryCode,
      this.themColorHexIOS,
      required this.currencyCode});
}
