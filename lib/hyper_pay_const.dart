part of 'flutter_hyperpay.dart';

class PaymentConst {
  
  static const String MADA = "MADA";
  static const String APPLEPAY = "APPLEPAY";
  static const String Credit = "credit";
  static const String STC_PAY = "STC_PAY";
  static const String ReadyUI = "ReadyUI";
  static const String StoredCards = "StoredCards";
  static const String CustomUI = "CustomUI";
  static const String gethyperpayresponse = "gethyperpayresponse";
  static const String success = "success";
  static const String error = "error";
  static const String SYNC = "SYNC";
  static const String PayTypeSotredCard = "PayTypeSotredCard";
  static const String PayTypeFromInput = "PayTypeFromInput";
  static const String EnabledTokenization = "true";
  static const String DisableTokenization = "false";
  static const String CountryCode = "SA";
  static const String CurrencyCode = "SAR";
  static const String iosARLang = "ar";
  static const String iosENLang = "en";
  static const String AndroidENLang = "en_US";
  static const String AndroidARLang = "ar_AR";
}

class PaymentBrands {
  static const String MADA = "MADA";
  static const String APPLEPAY = "APPLEPAY";
  static const String Credit = "credit";
  static const String STC_PAY = "STC_PAY";
  static const String MASTERCARD = "MASTERCARD";
  static const String VISA = "VISA";
}

class PaymentResultData {
  String? errorString;
  PaymentResult paymentResult;
  PaymentResultData({
    required this.errorString,
    required this.paymentResult,
  });
}

class ApplePay {
  String applePayBundel;
  String cuntryCode;
  String currencyCode;
  String checkoutid;
  String? iosPluginColor;
  ApplePay(
      {required this.applePayBundel,
      required this.checkoutid,
      required this.cuntryCode, this.iosPluginColor,
      required this.currencyCode});
}

class PaymentLang {
  static const String iosARLang = "ar";
  static const String iosENLang = "en";
  static const String AndroidENLang = "en_US";
  static const String AndroidARLang = "ar_AR";
}

enum PaymentResult { SYNC, SUCCESS, ERROR, NORESULT }

extension ToString on PaymentResult {
  String get value => toString().split('.').last;
}

enum PaymentMode { LIVE, TEST }

extension ToString1 on PaymentMode {
  String get value => toString().split('.').last;
}

extension ToString2 on PaymentBrands {
  String get value => toString().split('.').last;
}
