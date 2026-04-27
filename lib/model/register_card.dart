import '../flutter_hyperpay.dart';

class RegisterCard {
  String paymentType = PaymentConst.registerCard;
  String checkoutId;
  String brandName;
  String cardNumber;
  String holderName;
  String month;
  String year;
  String cvv;

  RegisterCard({
    required this.checkoutId,
    required this.brandName,
    required this.cardNumber,
    required this.holderName,
    required this.month,
    required this.year,
    required this.cvv,
  });
}
