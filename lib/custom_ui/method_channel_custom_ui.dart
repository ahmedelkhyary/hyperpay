import 'package:flutter/services.dart';
import '../flutter_hyperpay.dart';

Future<PaymentResultData> implementPaymentCustomUI({
  required PaymentMode paymentMode,
  required String brand,
  required String checkoutId,
  required String channelName,
  required String shopperResultUrl,
  required String lang,
  required String cardNumber,
  required String holderName,
  required int month,
  required int year,
  required int cvv,
  required bool payTypeStoredCard,
  required bool enabledTokenization,
}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getCustomUiModelCards(
        brand: brand,
        checkoutId: checkoutId,
        shopperResultUrl: shopperResultUrl,
        paymentMode: paymentMode,
        cardNumber: cardNumber,
        holderName: holderName,
        month: month,
        year: year,
        cvv: cvv,
        lang: lang,
        enabledTokenization: enabledTokenization,
        payTypeStoredCard: payTypeStoredCard,
      ),
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}

Map<String, String?> getCustomUiModelCards({
  required PaymentMode paymentMode,
  required String brand,
  required String checkoutId,
  required String shopperResultUrl,
  required String lang,
  required String cardNumber,
  required String holderName,
  required int month,
  required int year,
  required int cvv,
  required bool payTypeStoredCard,
  required bool enabledTokenization,
}) {
  return {
    "type": PaymentConst.customUi,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brand,
    "lang": lang,
    "card_number": cardNumber,
    "holder_name": holderName,
    "month": month.toString(),
    "year": year.toString(),
    "cvv": cvv.toString(),
    "PayTypeStoredCard": payTypeStoredCard.toString(),
    "EnabledTokenization": enabledTokenization.toString(),
    "ShopperResultUrl": shopperResultUrl,
  };
}
