import '../flutter_hyperpay.dart';

/// This class is used to define a CustomUI object which is used to make payments using the PaymentConst.
/// customUi payment type. It has parameters to define the checkoutId, brandName,
/// cardNumber, holderName, month, year, cvv and enabledTokenization (optional).
class CustomUI {
  String paymentType = PaymentConst.customUi;
  String checkoutId;
  String brandName;
  String cardNumber;
  String holderName;
  int month;
  int year;
  int cvv;
  bool enabledTokenization;

  CustomUI({
    required this.checkoutId,
    required this.brandName,
    required this.cardNumber,
    required this.holderName,
    required this.month,
    required this.year,
    required this.cvv,
    this.enabledTokenization = false,
  });
}
