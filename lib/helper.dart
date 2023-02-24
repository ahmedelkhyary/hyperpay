part of 'flutter_hyperpay.dart';

class PaymentResultManger {
  static PaymentResultData getPaymentResult(String paymentResult) {
    if (paymentResult == PaymentConst.success) {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.success);
    } else if (paymentResult == PaymentConst.sync) {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.sync);
    } else {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.noResult);
    }
  }
}
