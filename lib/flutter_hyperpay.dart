import 'dart:async';

import 'model/custom_ui.dart';
import 'model/custom_ui_stc.dart';
import 'model/ready_ui.dart';
import 'model/stored_cards.dart';
import 'src/custom_ui/method_channel_custom_ui.dart';
import 'src/custom_ui/method_channel_custom_ui_stc.dart';
import 'src/ready_ui/method_channel_ready_ui.dart';
import 'src/store_cards/method_channel_store_cards.dart';

part 'hyper_pay_const.dart';

part 'enum.dart';

class FlutterHyperPay {
  String channelName = "Hyperpay.demo.fultter/channel";
  String shopperResultUrl = "";
  String lang;
  PaymentMode paymentMode;

  FlutterHyperPay({
    required this.shopperResultUrl,
    required this.paymentMode,
    required this.lang,
  });

  /// This async function takes a ReadyUI object as input and returns a Future object of type PaymentResultData.
  /// It implements a payment operation by passing the Brand name, Checkout ID, Shopper Result URL,
  /// Payment Channel name, Payment mode, Language, Theme color in HEX (iOS),
  /// and a flag to set the store payment details mode.
  /// The function waits for the payment operation to complete and returns the resulting PaymentResultData.
  Future<PaymentResultData> readyUICards({required ReadyUI readyUI}) async {
    return await implementPayment(
      brands: readyUI.brandsName,
      checkoutId: readyUI.checkoutId,
      shopperResultUrl: shopperResultUrl,
      channelName: channelName,
      paymentMode: paymentMode,
      merchantId: readyUI.merchantIdApplePayIOS,
      countryCode: readyUI.countryCodeApplePayIOS,
      companyName: readyUI.companyNameApplePayIOS,
      lang: lang,
      themColorHexIOS: readyUI.themColorHexIOS,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

  /// This method is used for making custom UI payments with cards.
  /// It takes in the required CustomUI input and returns a PaymentResultData object.
  Future<PaymentResultData> customUICards({required CustomUI customUI}) async {
    return await implementPaymentCustomUI(
      brand: customUI.brandName,
      checkoutId: customUI.checkoutId,
      shopperResultUrl: shopperResultUrl,
      channelName: channelName,
      paymentMode: paymentMode,
      cardNumber: customUI.cardNumber,
      holderName: customUI.holderName,
      month: customUI.month,
      year: customUI.year,
      cvv: customUI.cvv,
      lang: lang,
      enabledTokenization: customUI.enabledTokenization,
    );
  }

  /// This function is used to do payment using custom UI. It takes "CustomUI" as an argument,
  /// which consists of the brand name, checkout id, card number, holder name, month, year and cvv.
  /// The function returns a Future of PaymentResultData.
  Future<PaymentResultData> customUISTC(
      {required CustomUISTC customUISTC}) async {
    return await implementPaymentCustomUISTC(
      checkoutId: customUISTC.checkoutId,
      shopperResultUrl: shopperResultUrl,
      channelName: channelName,
      paymentMode: paymentMode,
      lang: lang,
      phoneNumber: customUISTC.phoneNumber,
    );
  }

  /// This function allows the user to make payments using their stored cards.
  /// It accepts an argument of type StoredCards and makes a call to the implementPaymentStoredCards
  /// function with the values required for the payment.
  /// It returns a Future<PaymentResultData> which is the outcome of the payment.
  Future<PaymentResultData> payWithSoredCards(
      {required StoredCards storedCards}) async {
    return await implementPaymentStoredCards(
      brand: storedCards.brandName,
      checkoutId: storedCards.checkoutId,
      tokenId: storedCards.tokenId,
      cvv: storedCards.cvv,
      shopperResultUrl: shopperResultUrl,
      channelName: channelName,
      paymentMode: paymentMode,
      lang: lang,
    );
  }
}
