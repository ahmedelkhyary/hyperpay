import 'package:flutter/services.dart';
import '../flutter_hyperpay.dart';

///implements the payment using Apple Pay
///[applePay] an [ApplePay] instance
///[channelName] the name of platform for calling methods
///[shopperResultUrl] a url to show the result of payment
///[paymentMode] a [PaymentMode] to determine the payment mode
///[lang] language used in the payment
/// returns a [Future] of type [PaymentResultData]
Future<PaymentResultData> implementPaymentApplePay({
  required ApplePay applePay,
  required String channelName,
  required String shopperResultUrl,
  required PaymentMode paymentMode,
  required String lang,
}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getReadyModelApplePay(
          applePayBundel: applePay.applePayBundel,
          brand: PaymentBrands.applePay,
          countryCode: applePay.countryCode,
          currencyCode: applePay.currencyCode,
          checkoutId: applePay.checkoutId,
          channelName: channelName,
          paymentMode: paymentMode,
          lang: lang,
          shopperResultUrl: shopperResultUrl,
          companyName: applePay.companyName,
          themColorHexIOS: applePay.themColorHexIOS),
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}

/// This function prepares a model for Apple Pay payment.
/// It takes the required parameters such as brand, checkoutId,
/// applePayBundle, country code, currency code, channel name,
/// shopperResultUrl, paymentMode, and language, and the optionally themColorHexIOS and companyName.
/// It then returns a Map with the type, mode, checkoutid, brand, language,
/// themColorHexIOS, companyName, shopperResultUrl, applePayBundel, country code, and currency code.
Map<String, String> getReadyModelApplePay({
  required String brand,
  required String checkoutId,
  required String applePayBundel,
  required String countryCode,
  required String currencyCode,
  required String channelName,
  required String shopperResultUrl,
  required PaymentMode paymentMode,
  required String lang,
  String? themColorHexIOS = "",
  String? companyName = "",
}) {
  return {
    "type": PaymentConst.applePay,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brand,
    "lang": lang,
    "themColorHexIOS": themColorHexIOS ?? "",
    "companyName": companyName ?? "",
    "ShopperResultUrl": shopperResultUrl,
    "ApplePayBundel": applePayBundel,
    "CountryCode": countryCode,
    "CurrencyCode": currencyCode,
  };
}
