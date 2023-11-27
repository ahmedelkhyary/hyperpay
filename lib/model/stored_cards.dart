import '../flutter_hyperpay.dart';

/// This is the class for StoredCards. It has fields to store payment type,
/// checkoutId, tokenId, brandName and cvv. PaymentType is set to the PaymentConst.readyUi,
/// checkoutId and tokenId are required fields and brandName and cvv are optional fields.
class StoredCards {
  /// initializes a variable named paymentType with the value PaymentConst.customUi.
  String paymentType = PaymentConst.readyUi;

  /// declares a string variable named checkoutId without assigning it an initial value.
  String checkoutId;

  /// a "tokenId" often refers to a unique identifier associated with a payment method or transaction. It's commonly used in tokenization processes, where sensitive payment information (such as credit card details) is replaced with a secure token.
  String tokenId;

  ///  brandName variable could be used to store the name of the brand or company
  String? brandName;

  /// the cvv variable holds the three- or four-digit security code printed on the back (for Visa, Mastercard, and Discover)
  String cvv;

  StoredCards({
    this.paymentType = PaymentConst.readyUi,
    required this.checkoutId,
    this.brandName,
    required this.tokenId,
    required this.cvv,
  });
}
