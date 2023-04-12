part of 'flutter_hyperpay.dart';

class ApplePay {
  String applePayBundel;
  String countryCode;
  String currencyCode;
  String checkoutId;
  String? themColorHexIOS;
  String? companyName;

  ApplePay(
      {required this.applePayBundel,
      required this.checkoutId,
      required this.countryCode,
      this.themColorHexIOS,
      this.companyName,
      required this.currencyCode});
}
