import 'package:flutter/services.dart';
import 'flutter_hyperpay.dart';

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
          cuntryCode: applePay.countryCode,
          currencyCode: applePay.currencyCode,
          checkoutId: applePay.checkoutId,
          channelName: channelName,
          paymentMode: paymentMode,
          lang: lang,
          shopperResultUrl: shopperResultUrl,
          iosPluginColor: applePay.iosPluginColor),
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}

Map<String, String> getReadyModelApplePay({
  required String brand,
  required String checkoutId,
  required String applePayBundel,
  required String cuntryCode,
  required String currencyCode,
  required String channelName,
  required String shopperResultUrl,
  required PaymentMode paymentMode,
  required String lang,
  String? iosPluginColor = "",
}) {
  return {
    "type": PaymentConst.applePay,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brand,
    "lang": lang,
    "iosPluginColor": iosPluginColor ?? "",
    "ShopperResultUrl": shopperResultUrl,
    "ApplePayBundel": applePayBundel,
    "CountryCode": cuntryCode,
    "CurrencyCode": currencyCode,
  };
}
