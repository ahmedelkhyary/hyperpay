import 'dart:async';
import 'package:hyperpay_plugin/custom_ui/method_channel_custom_ui.dart';
import 'package:hyperpay_plugin/custom_ui/method_channel_custom_ui_stc.dart';

import 'store_cards/method_channel_store_cards.dart';
import 'apple_pay/method_channel_apple_pay.dart';
import 'ready_ui/method_channel_ready_ui.dart';

part 'hyper_pay_const.dart';

part 'helper/helper.dart';

part 'ready_ui/ready_ui.dart';

part 'custom_ui/custom_ui.dart';

part 'custom_ui/custom_ui_stc.dart';

part 'store_cards/stored_cards.dart';

part 'enum.dart';

part 'apple_pay/apple_pay.dart';

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

  Future<PaymentResultData> readyUICards({required ReadyUI readyUI}) async {
    return await implementPayment(
      brand: readyUI.brandName,
      checkoutId: readyUI.checkoutId,
      shopperResultUrl: shopperResultUrl,
      channelName: channelName,
      paymentMode: paymentMode,
      lang: lang,
      themColorHexIOS: readyUI.themColorHexIOS,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

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

  Future<PaymentResultData> payWithApplePay(
      {required ApplePay applePay}) async {
    return await implementPaymentApplePay(
        applePay: applePay,
        shopperResultUrl: shopperResultUrl,
        channelName: channelName,
        paymentMode: paymentMode,
        lang: lang);
  }

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
