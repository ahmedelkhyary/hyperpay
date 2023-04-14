part of '../flutter_hyperpay.dart';

/// This is a class for Apple Pay to handle payments and transactions.
/// It requires an applePayBundel, a checkoutId, a countryCode,
/// and a currencyCode for initialization.
/// It also optionally allows for a themColorHexIOS and a companyName.
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
