part of 'flutter_hyperpay.dart';

class StoredCards {
  String paymentType = PaymentConst.readyUi;
  String checkoutId;
  String tokenId;
  String? brandName;
  String cvv;

  StoredCards({
    this.paymentType = PaymentConst.readyUi,
    required this.checkoutId,
    this.brandName,
    required this.tokenId,
    required this.cvv,
  });
}
