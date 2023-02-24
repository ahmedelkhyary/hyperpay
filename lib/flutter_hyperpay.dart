import 'dart:async';
import 'package:flutter/services.dart';

part 'hyper_pay_const.dart';

part 'helper.dart';

part 'ready_ui.dart';

part 'stored_cards.dart';

class FlutterHyperpay {
  String channeleName = "";
  String shopperResultUrl = "";
  String lang;
  PaymentMode paymentMode;

  FlutterHyperpay({
    required this.channeleName,
    required this.shopperResultUrl,
    required this.paymentMode,
    required this.lang,
  });

  void initFlutterHyperPay({
    required String channeleName,
    required String shopperResultUrl,
    required PaymentMode paymentMode,
    required String lang,
  }) {
    this.channeleName = channeleName;
    this.shopperResultUrl = shopperResultUrl;
    this.lang = lang;
    this.paymentMode = paymentMode;
  }

  Future<PaymentResultData> readyUIVisa({required ReadyUI readyUI}) async {
    return await implementPayment(
      brand: PaymentBrands.VISA,
      checkoutid: readyUI.checkoutid,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

  Future<PaymentResultData> readyUIMada({required ReadyUI readyUI}) async {
    return await implementPayment(
      brand: PaymentBrands.MADA,
      checkoutid: readyUI.checkoutid,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

  Future<PaymentResultData> readyUIMaster({required ReadyUI readyUI}) async {
    return await implementPayment(
      brand: PaymentBrands.MASTERCARD,
      checkoutid: readyUI.checkoutid,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

  Future<PaymentResultData> readyUICards({required ReadyUI readyUI}) async {
    return await implementPayment(
      brand: readyUI.brandName,
      checkoutid: readyUI.checkoutid,
      iosPluginColor: readyUI.iosPluginColor,
      setStorePaymentDetailsMode: readyUI.setStorePaymentDetailsMode,
    );
  }

  Future<PaymentResultData> payWithSoredCards(
      {required StoredCards storedCards}) async {
    return await implementPaymentStoredCards(
      brand: storedCards.brandName,
      checkoutid: storedCards.checkoutid,
      tokenId: storedCards.tokenId,
      cvv: storedCards.cvv,
    );
  }

  Future<PaymentResultData> payWithApplePay(
      {required ApplePay applePay}) async {
    return await implementPaymentApplePay(applePay: applePay);
  }

  Future<PaymentResultData> implementPayment(
      {required String? brand,
      required String checkoutid,
      String? iosPluginColor,
      required bool setStorePaymentDetailsMode}) async {
    String transactionStatus;
    var platform = MethodChannel(channeleName);
    try {
      final String? result = await platform.invokeMethod(
        PaymentConst.gethyperpayresponse,
        getReadyModelCards(
          brand: brand,
          checkoutid: checkoutid,
          iosPluginColor: iosPluginColor,
          setStorePaymentDetailsMode: setStorePaymentDetailsMode,
        ),
      );
      transactionStatus = '$result';
      return PaymentResultManger.getPaymentResult(transactionStatus);
    } on PlatformException catch (e) {
      transactionStatus = "${e.message}";
      return PaymentResultData(
          errorString: e.message, paymentResult: PaymentResult.ERROR);
    }
    // return PaymentResultManger.getPaymentResult(transactionStatus);
  }

  Future<PaymentResultData> implementPaymentStoredCards({
    required String? brand,
    required String checkoutid,
    required String tokenId,
    required String cvv,
  }) async {
    String transactionStatus;
    var platform = MethodChannel(channeleName);
    try {
      final String? result = await platform.invokeMethod(
        PaymentConst.gethyperpayresponse,
        getPaymentWithCards(
          tokenId: tokenId,
          brand: brand,
          cvv: cvv,
          checkoutid: checkoutid,
        ),
      );
      transactionStatus = '$result';
      return PaymentResultManger.getPaymentResult(transactionStatus);
    } on PlatformException catch (e) {
      transactionStatus = "${e.message}";
      return PaymentResultData(
          errorString: e.message, paymentResult: PaymentResult.ERROR);
    }
    // return PaymentResultManger.getPaymentResult(transactionStatus);
  }

  Future<PaymentResultData> implementPaymentApplePay(
      {required ApplePay applePay}) async {
    String transactionStatus;
    var platform = MethodChannel(channeleName);
    try {
      final String? result = await platform.invokeMethod(
        PaymentConst.gethyperpayresponse,
        getReadyModelApplePay(
            applePayBundel: applePay.applePayBundel,
            brand: PaymentBrands.APPLEPAY,
            cuntryCode: applePay.cuntryCode,
            currencyCode: applePay.currencyCode,
            checkoutid: applePay.checkoutid,
            iosPluginColor: applePay.iosPluginColor),
      );
      transactionStatus = '$result';
      return PaymentResultManger.getPaymentResult(transactionStatus);
    } on PlatformException catch (e) {
      transactionStatus = "${e.message}";
      return PaymentResultData(
          errorString: e.message, paymentResult: PaymentResult.ERROR);
    }
    // return PaymentResultManger.getPaymentResult(transactionStatus);
  }

  ///get Ready Model Cards
  Map<String, String?> getReadyModelCards(
      {required String? brand,
      required String checkoutid,
      String? iosPluginColor,
      required bool setStorePaymentDetailsMode}) {
    return {
      "type": PaymentConst.ReadyUI,
      "mode": paymentMode.toString().split('.').last,
      "checkoutid": checkoutid,
      "brand": brand,
      "lang": lang,
      "iosPluginColor": iosPluginColor ?? "",
      "ShopperResultUrl": shopperResultUrl,
      "setStorePaymentDetailsMode": setStorePaymentDetailsMode.toString(),
    };
  }

  ///get Ready Model Cards
  Map<String, String> getReadyModelApplePay({
    required String brand,
    required String checkoutid,
    required String applePayBundel,
    required String cuntryCode,
    required String currencyCode,
    String? iosPluginColor = "",
  }) {
    return {
      "type": PaymentConst.APPLEPAY,
      "mode": paymentMode.toString().split('.').last,
      "checkoutid": checkoutid,
      "brand": brand,
      "lang": lang,
      "iosPluginColor": iosPluginColor ?? "",
      "ShopperResultUrl": shopperResultUrl,
      "ApplePayBundel": applePayBundel,
      "CountryCode": cuntryCode,
      "CurrencyCode": currencyCode,
    };
  }

  ///get Payment With Cards
  Map<String, String?> getPaymentWithCards({
    required String? brand,
    required String checkoutid,
    required String tokenId,
    required String cvv,
  }) {
    return {
      "type": PaymentConst.StoredCards,
      "mode": paymentMode.toString().split('.').last,
      "checkoutid": checkoutid,
      "brand": brand,
      "lang": lang,
      "ShopperResultUrl": shopperResultUrl,
      "TokenID": tokenId,
      "cvv": cvv,
    };
  }
}
