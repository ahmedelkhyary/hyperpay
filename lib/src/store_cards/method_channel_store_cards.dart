import 'package:flutter/services.dart';
import '../../flutter_hyperpay.dart';
import '../helper/helper.dart';

/// This function is used to implement payment using stored cards.
/// The [brand] should be provided for the payment.
/// The [checkoutId] should be provided for the payment.
/// The [tokenId] should be provided for the payment.
/// The [cvv] should be provided for the payment.
/// The [channelName] should be provided for the payment.
/// The [shopperResultUrl] should be provided for the payment.
/// The [paymentMode] should be provided for the payment.
/// The [lang] should be provided for the payment.
/// It will return a [Future<PaymentResultData>] object that contains the payment result.
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

/// This function is used to get payment with cards with the required parameters.
/// It takes in an required brand, checkoutId, tokenId, cvv, channelName, shopperResultUrl,
/// paymentMode and lang and returns a map containing the type, mode, checkoutid,
/// brand, lang, ShopperResultUrl, TokenID and cvv.
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
