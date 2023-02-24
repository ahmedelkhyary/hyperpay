part of 'flutter_hyperpay.dart';

class ReadyUI {
  String paymentType = PaymentConst.ReadyUI;
  String checkoutid;
  bool setStorePaymentDetailsMode;
  String? brandName;
  String? iosPluginColor;

  ReadyUI({
    this.paymentType = PaymentConst.ReadyUI,
    required this.checkoutid,
    this.brandName,
    this.iosPluginColor,
    this.setStorePaymentDetailsMode = false,
  });
}
