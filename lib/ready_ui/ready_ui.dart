part of '../flutter_hyperpay.dart';

/// ReadyUI class holds all the necessary data related to the ReadyUI payment method
/// which is used in PaymentConst. It is required to provide checkoutId when initializing the class.
/// Also, we can provide brandName and themColorHexIOS as optional values.
/// setStorePaymentDetailsMode is set to false by default.
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
