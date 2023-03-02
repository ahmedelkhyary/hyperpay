import 'dart:async';
import 'method_channel_store_cards.dart';
import 'method_channel_apple_pay.dart';
import 'method_channel_ready_ui.dart';

part 'hyper_pay_const.dart';

part 'helper.dart';

part 'ready_ui.dart';

part 'stored_cards.dart';

part 'enum.dart';

part 'apple_pay.dart';

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
      iosPluginColor: readyUI.iosPluginColor,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
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
