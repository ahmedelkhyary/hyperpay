import '../../flutter_hyperpay.dart';

/// PaymentResultManger is a class used to generate a PaymentResultData
/// object based on the paymentResult passed. It will return the respective paymentResult
/// with the errorString depending on the paymentResult passed.
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
