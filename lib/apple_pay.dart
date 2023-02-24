part of 'flutter_hyperpay.dart';

class ApplePay {
  String applePayBundel;
  String countryCode;
  String currencyCode;
  String checkoutId;
  String? iosPluginColor;

  ApplePay(
      {required this.applePayBundel,
      required this.checkoutId,
      required this.countryCode,
      this.iosPluginColor,
      required this.currencyCode});
}
