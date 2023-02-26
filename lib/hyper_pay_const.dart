part of 'flutter_hyperpay.dart';

class PaymentConst {
  static const String applePay = "APPLEPAY";
  static const String readyUi = "ReadyUI";
  static const String storedCards = "StoredCards";
  static const String methodCall = "gethyperpayresponse";
  static const String success = "success";
  static const String error = "error";
  static const String sync = "SYNC";
}

class PaymentBrands {
  static const String mada = "MADA";
  static const String applePay = "APPLEPAY";
  static const String credit = "credit";
  static const String stcPay = "STC_PAY";
  static const String masterCard = "MASTERCARD";
  static const String visa = "VISA";
}

class PaymentResultData {
  String? errorString;
  PaymentResult paymentResult;

  PaymentResultData({
    required this.errorString,
    required this.paymentResult,
  });
}

class PaymentLang {
  static const String iosARLang = "ar";
  static const String iosENLang = "en";
  static const String androidENLang = "en_US";
  static const String androidARLang = "ar_AR";
}
