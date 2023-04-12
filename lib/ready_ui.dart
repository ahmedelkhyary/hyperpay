part of 'flutter_hyperpay.dart';

class ReadyUI {
  String paymentType = PaymentConst.readyUi;
  String checkoutId;
  bool setStorePaymentDetailsMode;
  String? brandName;
  String? themColorHexIOS;

  ReadyUI({
    this.paymentType = PaymentConst.readyUi,
    required this.checkoutId,
    this.brandName,
    this.themColorHexIOS,
    this.setStorePaymentDetailsMode = false,
  });
}
