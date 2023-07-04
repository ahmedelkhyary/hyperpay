import 'package:flutter/services.dart';

import '../../flutter_hyperpay.dart';
import '../helper/helper.dart';

/// This function implements the payment with the provided payment details.
/// It takes in parameters like brand, checkoutId, channelName, etc. which are essential for the payment to happen.
/// It returns a PaymentResultData object which is processed and managed by PaymentResultManger.
/// If there is any error, it is caught and a PaymentResultData object with error string is returned.
Future<PaymentResultData> implementPayment(
    {required List<String> brands,
    required String checkoutId,
    required String channelName,
    required String shopperResultUrl,
    required String lang,
    required PaymentMode paymentMode,
    required String merchantId,
    required String countryCode,
    String? companyName = "",
    String? themColorHexIOS,
    required bool setStorePaymentDetailsMode}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getReadyModelCards(
        brands: brands,
        checkoutId: checkoutId,
        themColorHexIOS: themColorHexIOS,
        shopperResultUrl: shopperResultUrl,
        paymentMode: paymentMode,
        countryCode: countryCode,
        merchantId: merchantId,
        companyName: companyName,
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

/// This function retrieves the necessary attributes to create a ready-to-use model card.
/// It takes in the required parameters of brand, checkoutId, shopperResultUrl, lang,
/// paymentMode, and setStorePaymentDetailsMode. An optional parameter, themColorHexIOS,
/// can also be provided. The function returns a Map with the corresponding values of type, mode,
/// checkoutid, brand, lang, themColorHexIOS, ShopperResultUrl, and setStorePaymentDetailsMode.
Map<String, dynamic> getReadyModelCards(
    {required List<String> brands,
    required String checkoutId,
    required String shopperResultUrl,
    required String lang,
    required PaymentMode paymentMode,
    required String merchantId,
    required String countryCode,
    String? companyName = "",
    String? themColorHexIOS,
    required bool setStorePaymentDetailsMode}) {
  return {
    "type": PaymentConst.readyUi,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "brand": brands,
    "lang": lang,
    "merchantId": merchantId,
    "CountryCode": countryCode,
    "companyName": companyName ?? "",
    "themColorHexIOS": themColorHexIOS ?? "",
    "ShopperResultUrl": shopperResultUrl,
    "setStorePaymentDetailsMode": setStorePaymentDetailsMode.toString(),
  };
}
