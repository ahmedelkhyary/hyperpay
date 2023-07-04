import '../flutter_hyperpay.dart';

/// Class CustomUISTC is used to store the payment type,
/// checkout ID, and phone number for custom UI payment.
class CustomUISTC {
  String paymentType = PaymentConst.customUi;
  String checkoutId;
  String phoneNumber;

  CustomUISTC({
    required this.checkoutId,
    required this.phoneNumber,
  });
}
