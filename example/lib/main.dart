import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/custom_ui.dart';
import 'package:hyperpay_plugin/model/custom_ui_stc.dart';
import 'package:hyperpay_plugin/model/hyper.pay.status.model.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyperpay Demo',
      theme: ThemeData(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  late FlutterHyperPay flutterHyperPay;
  //
  @override
  void initState() {
    //
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl,
      paymentMode: PaymentMode.test,
      lang: InAppPaymentSetting.getLang(),
    );
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hyperpay Demo"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  ///
                  /// get checkout id
                  ///
                  String? checkoutId = await getCheckOut(100.0, 'BD');
                  dev.log("checkoutId: $checkoutId");
                  if (checkoutId == null) return;

                  ///
                  /// load ui
                  ///
                  final paymentResultData = await payRequestNowReadyUI(
                    flutterHyperPay: flutterHyperPay,
                    brandsName: [
                      "VISA",
                      "MASTER",
                      "MADA",
                      "PAYPAL",
                      "STC_PAY",
                      "APPLEPAY",
                    ],
                    checkoutId: checkoutId,
                  );
                  dev.log("paymentResultData: $paymentResultData");
                  if (paymentResultData.paymentResult.isSuccess) {
                    ///
                    /// check out status
                    ///
                    dev.log('Hello Payment Success. Id: $checkoutId');
                    final res = await checkStatus(checkoutId);
                    // if (res.result?.code != successCode) {
                    //   dev.log(res.result?.description ?? "Error");
                    //   return;
                    // }
                    dev.log("HyperpayStatus Check Status: ${res.result?.code}");
                    dev.log(
                        "HyperpayStatus Check Status: ${res.result?.description}");
                  }
                },
                child: const Card(
                  child: ListTile(
                    title: Text(
                      "Pay with Ready UI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    subtitle: Text(
                      "VISA, MASTER, MADA, STC_PAY, APPLEPAY",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  ///
                  /// get checkout id
                  ///
                  String? checkoutId = await getCheckOut(200.0, 'BD');
                  dev.log("checkoutId: $checkoutId");
                  if (checkoutId == null) return;

                  ///
                  /// load ui
                  ///
                  final paymentResultData = await payRequestNowCustomUi(
                    flutterHyperPay: flutterHyperPay,
                    brandName: "MADA",
                    checkoutId: checkoutId,
                    cardNumber: "4464040000000007",
                  );
                  dev.log("paymentResultData: $paymentResultData");
                  if (paymentResultData.paymentResult.isSuccess) {
                    ///
                    /// check out status
                    ///
                    dev.log('Hello Payment Success. Id: $checkoutId');
                    final res = await checkStatus(checkoutId);
                    // if (res.result?.code != successCode) {
                    //   dev.log(res.result?.description ?? "Error");
                    //   return;
                    // }
                    dev.log("HyperpayStatus Check Status: ${res.result?.code}");
                    dev.log(
                        "HyperpayStatus Check Status: ${res.result?.description}");
                  }
                },
                child: const Card(
                  child: ListTile(
                    title: Text(
                      "Pay with Custom UI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    subtitle: Text(
                      "CUSTOM_UI",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  ///
                  /// get checkout id
                  ///
                  String? checkoutId = await getCheckOut(300.0, 'BD');
                  dev.log("checkoutId: $checkoutId");
                  if (checkoutId == null) return;

                  ///
                  /// load ui
                  ///
                  final paymentResultData = await payRequestNowCustomUiSTCPAY(
                    flutterHyperPay: flutterHyperPay,
                    checkoutId: checkoutId,
                    phoneNumber: "0588987147",
                  );
                  dev.log("paymentResultData: $paymentResultData");
                  if (paymentResultData.paymentResult.isSuccess) {
                    ///
                    /// check out status
                    ///
                    dev.log('Hello Payment Success. Id: $checkoutId');
                    final res = await checkStatus(checkoutId);
                    // if (res.result?.code != successCode) {
                    //   dev.log(res.result?.description ?? "Error");
                    //   return;
                    // }
                    dev.log("HyperpayStatus Check Status: ${res.result?.code}");
                    dev.log(
                        "HyperpayStatus Check Status: ${res.result?.description}");
                  }
                },
                child: const Card(
                  child: ListTile(
                    title: Text(
                      "Pay with Custom UI STC",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    subtitle: Text(
                      "STC_PAY",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// URL TO GET CHECKOUT ID FOR TEST
/// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php
///
///=================================================
///Constant Functions
///=================================================
///
class InAppPaymentSetting {
  static const String companyName = "Test Co";
  static const String shopperResultUrl = "com.testpayment.payment";
  static const String checkoutUrl = "<your-checkout-url>";
  static const String merchantId = "<your-merchant-id>";
  static const String countryCode = "<your-country-code>"; // BD
  static const String authorization = "Bearer <your-token>";
  static const String cookie = "<your cookie>";
  static getLang() {
    if (Platform.isIOS) {
      return "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}

///
/// To get the checkout id with passing the amount and currency and payment type
///
Future<String?> getCheckOut(double price, String currency,
    [String paymentType = 'DB']) async {
  final amount = price.toStringAsFixed(2);
  final url = Uri.parse(
      '${InAppPaymentSetting.checkoutUrl}?entityId=${InAppPaymentSetting.merchantId}&amount=$amount&currency=$currency&paymentType=$paymentType');
  debugPrint(url.toString());
  var request = http.Request('POST', url);

  request.headers.addAll({
    'Authorization': InAppPaymentSetting.authorization,
    'Cookie': InAppPaymentSetting.cookie,
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final body = await response.stream.bytesToString();
    return json.decode(body)['id'];
  } else {
    final body = await response.stream.bytesToString();
    dev.log(body.toString(), name: "STATUS CODE ERROR");
    return null;
  }
}

///
/// To know the status of the payment send by the (Only work in real merchant id)
///
Future<HyperpayStatus> checkStatus(String checkoutId) async {
  var request = http.Request(
      'GET',
      Uri.parse(
          'https://eu-test.oppwa.com/v1/checkouts/$checkoutId/payment?entityId=${InAppPaymentSetting.merchantId}'));

  request.headers.addAll({
    'Authorization': InAppPaymentSetting.authorization,
    'Cookie': InAppPaymentSetting.cookie,
  });

  http.StreamedResponse response = await request.send();
  final body = await response.stream.bytesToString();
  final hyperRes = hyperpayStatusFromJson(body);

  dev.log("HyperpayStatus Final: $hyperRes");

  return hyperRes;
}

///
/// To pay with ready ui
///
Future<PaymentResultData> payRequestNowReadyUI({
  required FlutterHyperPay flutterHyperPay,
  required List<String> brandsName,
  required String checkoutId,
}) async {
  return await flutterHyperPay.readyUICards(
    readyUI: ReadyUI(
      brandsName: brandsName,
      checkoutId: checkoutId,
      merchantIdApplePayIOS: InAppPaymentSetting.merchantId,
      countryCodeApplePayIOS: InAppPaymentSetting.countryCode,
      companyNameApplePayIOS: InAppPaymentSetting.companyName,
      themColorHexIOS: "#000000", // FOR IOS ONLY
      setStorePaymentDetailsMode: true, // store payment details for future use
    ),
  );
}

///
/// To pay with Custom ui
///
Future<PaymentResultData> payRequestNowCustomUi({
  required FlutterHyperPay flutterHyperPay,
  required String brandName,
  required String checkoutId,
  required String cardNumber,
}) async {
  return await flutterHyperPay.customUICards(
    customUI: CustomUI(
      brandName: brandName,
      checkoutId: checkoutId,
      cardNumber: cardNumber,
      holderName: "test name",
      month: 12,
      year: 2023,
      cvv: 123,
      enabledTokenization: false, // default
    ),
  );
}

///
/// To pay with Custom ui STC PAY
///
Future<PaymentResultData> payRequestNowCustomUiSTCPAY({
  required FlutterHyperPay flutterHyperPay,
  required String phoneNumber,
  required String checkoutId,
}) async {
  return await flutterHyperPay.customUISTC(
    customUISTC: CustomUISTC(
      checkoutId: checkoutId,
      phoneNumber: phoneNumber,
    ),
  );
}
