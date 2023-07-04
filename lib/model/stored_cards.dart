import '../flutter_hyperpay.dart';

/// This is the class for StoredCards. It has fields to store payment type,
/// checkoutId, tokenId, brandName and cvv. PaymentType is set to the PaymentConst.readyUi,
/// checkoutId and tokenId are required fields and brandName and cvv are optional fields.
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
