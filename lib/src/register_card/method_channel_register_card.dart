import 'package:flutter/services.dart';
import '../../flutter_hyperpay.dart';
import '../helper/helper.dart';

Future<PaymentResultData> implementRegisterCard({
  required PaymentMode paymentMode,
  required String brand,
  required String checkoutId,
  required String channelName,
  required String shopperResultUrl,
  required String lang,
  required String cardNumber,
  required String holderName,
  required String month,
  required String year,
  required String cvv,
}) async {
  String transactionStatus;
  var platform = MethodChannel(channelName);
  try {
    final String? result = await platform.invokeMethod(
      PaymentConst.methodCall,
      {
        "type": PaymentConst.registerCard,
        "mode": paymentMode.toString().split('.').last,
        "checkoutid": checkoutId,
        "brand": brand,
        "lang": lang,
        "card_number": cardNumber,
        "holder_name": holderName,
        "month": month,
        "year": year,
        "cvv": cvv,
        "ShopperResultUrl": shopperResultUrl,
      },
    );
    transactionStatus = '$result';
    return PaymentResultManger.getPaymentResult(transactionStatus);
  } on PlatformException catch (e) {
    transactionStatus = "${e.message}";
    return PaymentResultData(
        errorString: e.message, paymentResult: PaymentResult.error);
  }
}
