import 'package:flutter/services.dart';
import 'flutter_hyperpay.dart';

Future<PaymentResultData> implementPaymentStoredCards({
  required String? brand,
  required String checkoutId,
  required String tokenId,
  required String cvv,
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
      getPaymentWithCards(
          tokenId: tokenId,
          brand: brand,
          cvv: cvv,
          checkoutId: checkoutId,
          channelName: channelName,
          shopperResultUrl: shopperResultUrl,
          paymentMode: paymentMode,
          lang: lang),
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}

Map<String, String?> getPaymentWithCards({
  required String? brand,
  required String checkoutId,
  required String tokenId,
  required String cvv,
  required String channelName,
  required String shopperResultUrl,
  required PaymentMode paymentMode,
  required String lang,
}) {
  return {
    "type": PaymentConst.storedCards,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brand,
    "lang": lang,
    "ShopperResultUrl": shopperResultUrl,
    "TokenID": tokenId,
    "cvv": cvv,
  };
}
