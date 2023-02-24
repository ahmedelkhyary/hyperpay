part of 'flutter_hyperpay.dart';

class ReadyUI {
  String paymentType = PaymentConst.readyUi;
  String checkoutId;
  bool setStorePaymentDetailsMode;
  String? brandName;
  String? iosPluginColor;

  ReadyUI({
    this.paymentType = PaymentConst.readyUi,
    required this.checkoutId,
    this.brandName,
    this.iosPluginColor,
    this.setStorePaymentDetailsMode = false,
  });
}
