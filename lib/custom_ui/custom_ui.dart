part of '../flutter_hyperpay.dart';

class CustomUI {
  String paymentType = PaymentConst.customUi;
  String checkoutId;
  String brandName;
  String cardNumber;
  String holderName;
  int month;
  int year;
  int cvv;
  bool payTypeStoredCard;
  bool enabledTokenization;

  CustomUI({
    required this.checkoutId,
    required this.brandName,
    required this.cardNumber,
    required this.holderName,
    required this.month,
    required this.year,
    required this.cvv,
    this.payTypeStoredCard = false,
    this.enabledTokenization = false,
  });
}
