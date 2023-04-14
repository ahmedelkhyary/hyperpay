part of '../flutter_hyperpay.dart';

class CustomUISTC {
  String paymentType = PaymentConst.customUi;
  String checkoutId;
  String phoneNumber;

  CustomUISTC({
    required this.checkoutId,
    required this.phoneNumber,
  });
}
