part of '../flutter_hyperpay.dart';

class ReadyUI {
  String paymentType = PaymentConst.readyUi;
  String checkoutId;
  bool setStorePaymentDetailsMode;
  String? brandName;
  String? themColorHexIOS;

  ReadyUI({
    required this.checkoutId,
    this.brandName,
    this.themColorHexIOS,
    this.setStorePaymentDetailsMode = false,
  });
}
