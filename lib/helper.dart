
part of 'flutter_hyperpay.dart';
class PaymentResultManger {
  static PaymentResultData getPaymentResult(String paymentResult) {
    if (paymentResult == PaymentConst.success) {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.SUCCESS);
    } else if (paymentResult == PaymentConst.SYNC) {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.SYNC);
    } else {
      return PaymentResultData(
          errorString: '', paymentResult: PaymentResult.NORESULT);
    }
  }
}
