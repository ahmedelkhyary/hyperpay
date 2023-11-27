import '../flutter_hyperpay.dart';

/// Class CustomUISTC is used to store the payment type,
/// checkout ID, and phone number for custom UI payment.
class CustomUISTC {
  /// initializes a variable named paymentType with the value PaymentConst.customUi.
  String paymentType = PaymentConst.customUi;

  /// declares a string variable named checkoutId without assigning it an initial value.
  String checkoutId;

  /// The phone number for STC (Saudi Telecom Company) can vary depending on the specific region or service you are looking for
  String phoneNumber;

  CustomUISTC({
    required this.checkoutId,
    required this.phoneNumber,
  });
}
