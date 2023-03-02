import 'package:flutter/services.dart';
import 'flutter_hyperpay.dart';

Future<PaymentResultData> implementPayment(
    {required String? brand,
    required String checkoutId,
    required String channelName,
    required String shopperResultUrl,
    required String lang,
    required PaymentMode paymentMode,
    String? iosPluginColor,
    required bool setStorePaymentDetailsMode}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getReadyModelCards(
        brand: brand,
        checkoutId: checkoutId,
        iosPluginColor: iosPluginColor,
        shopperResultUrl: shopperResultUrl,
        paymentMode: paymentMode,
        lang: lang,
        setStorePaymentDetailsMode: setStorePaymentDetailsMode,
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

Map<String, String?> getReadyModelCards(
    {required String? brand,
    required String checkoutId,
    required String shopperResultUrl,
    required String lang,
    required PaymentMode paymentMode,
    String? iosPluginColor,
    required bool setStorePaymentDetailsMode}) {
  return {
    "type": PaymentConst.readyUi,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brand,
    "lang": lang,
    "iosPluginColor": iosPluginColor ?? "",
    "ShopperResultUrl": shopperResultUrl,
    "setStorePaymentDetailsMode": setStorePaymentDetailsMode.toString(),
  };
}
