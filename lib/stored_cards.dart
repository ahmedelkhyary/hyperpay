part of 'flutter_hyperpay.dart';

class StoredCards {
  String paymentType = PaymentConst.ReadyUI;
  String checkoutid;
  String tokenId;
  String? brandName;
  String cvv;
  StoredCards({
    this.paymentType = PaymentConst.ReadyUI,
    required this.checkoutid,
    this.brandName,
    required this.tokenId,
    required this.cvv,
  });
}
