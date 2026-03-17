import 'package:flutter/services.dart';

import '../../flutter_hyperpay.dart';
import '../helper/helper.dart';

/// Implements Google Pay payment through the method channel.
/// Takes checkout details and Google Pay configuration.
/// Returns PaymentResultData indicating success or failure.
Future<PaymentResultData> implementGooglePayPayment({
  required String checkoutId,
  required String channelName,
  required String shopperResultUrl,
  required String lang,
  required PaymentMode paymentMode,
  required String googlePayMerchantId,
  required String gatewayMerchantId,
  required String countryCode,
  required String currencyCode,
  required String amount,
  required List<String> allowedCardNetworks,
  required List<String> allowedCardAuthMethods,
}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      getGooglePayModel(
        checkoutId: checkoutId,
        shopperResultUrl: shopperResultUrl,
        paymentMode: paymentMode,
        lang: lang,
        googlePayMerchantId: googlePayMerchantId,
        gatewayMerchantId: gatewayMerchantId,
        countryCode: countryCode,
        currencyCode: currencyCode,
        amount: amount,
        allowedCardNetworks: allowedCardNetworks,
        allowedCardAuthMethods: allowedCardAuthMethods,
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

/// Builds the parameter map for Google Pay method channel call.
Map<String, dynamic> getGooglePayModel({
  required String checkoutId,
  required String shopperResultUrl,
  required String lang,
  required PaymentMode paymentMode,
  required String googlePayMerchantId,
  required String gatewayMerchantId,
  required String countryCode,
  required String currencyCode,
  required String amount,
  required List<String> allowedCardNetworks,
  required List<String> allowedCardAuthMethods,
}) {
  return {
    "type": PaymentConst.googlePay,
    "mode": paymentMode.toString().split('.').last,
    "checkoutid": checkoutId,
    "lang": lang,
    "ShopperResultUrl": shopperResultUrl,
    "googlePayMerchantId": googlePayMerchantId,
    "gatewayMerchantId": gatewayMerchantId,
    "countryCode": countryCode,
    "currencyCode": currencyCode,
    "amount": amount,
    "allowedCardNetworks": allowedCardNetworks,
    "allowedCardAuthMethods": allowedCardAuthMethods,
  };
}
