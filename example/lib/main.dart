import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hyperPayPlugin/flutter_hyperpay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late FlutterHyperpay flutterHyperPay ;
  @override
  void initState() {
    flutterHyperPay = FlutterHyperpay(
      channeleName: InAppPaymentSetting.channel,
      shopperResultUrl: InAppPaymentSetting.ShopperResultUrl, // For Android
      paymentMode:  PaymentMode.TEST,
      lang: InAppPaymentSetting.getLang(),
    );
    super.initState();
  }

  final int _counter = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
             "Payment",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getCheckOut(finalPrice: 1.0);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  getCheckOut({required double finalPrice}) async {



    var status;
    var _checkoutid ;

    // String myUrl = "http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php";
    // final response = await http.post(
    //   Uri.parse( myUrl),
    //   headers: {'Accept': 'application/json'},
    // );
    //
    // print(response.statusCode);
    // print(response.body);
    // print("------------");
    //
    // status = response.body.contains('error');
    //
    // var data = json.decode(response.body);
    //
    // if (status) {
    //   print('data : ${data["error"]}');
    // } else {
    //   print('data : ${data["id"]}');
    //    _checkoutid = '${data["id"]}';
    // }

      payRequestNow(
        checkoutId:  '20F163ED8DC6DBA29FBCE86A7E9C7297.uat01-vm-tx01', cardName: "VISA");

  }
  payRequestNow({required String cardName, required String checkoutId}) async {

    PaymentResultData paymentResultData;
    if (cardName.toLowerCase() ==
        InAppPaymentSetting.APPLEPAY.toLowerCase()) {
      paymentResultData = await flutterHyperPay.payWithApplePay(
        applePay: ApplePay(
          /// ApplePayBundel refer to Merchant ID
            applePayBundel: InAppPaymentSetting.ApplePaybundel,
            checkoutid: checkoutId,
            cuntryCode: InAppPaymentSetting.CountryCode,
            currencyCode: InAppPaymentSetting.CurrencyCode),
      );
    } else {
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
          brandName: cardName,
          checkoutid: checkoutId,
          setStorePaymentDetailsMode: false,
        ),
      );
    }

    print(paymentResultData.paymentResult.toString() * 20) ;
    print("--"*100);

    if (paymentResultData.paymentResult == PaymentResult.SUCCESS ||
        paymentResultData.paymentResult == PaymentResult.SYNC) {

      try {
      } catch (message) {}
    }

  }
}

class InAppPaymentSetting {
  static const String APPLEPAY="APPLEPAY";
  static const String ReadyUI="ReadyUI";
  static const String gethyperpayresponse="gethyperpayresponse";
  static const String success="success";
  static const String SYNC="SYNC";
  static const String PayTypeSotredCard="PayTypeSotredCard";
  static const String PayTypeFromInput="PayTypeFromInput";
  static const String EnabledTokenization="true";
  static const String DisableTokenization="false";
  static  String ShopperResultUrl= "com.testpayment.payment";
  static const String TestMode="TEST";
  static const String LiveMode="LIVE";
  static  String ApplePaybundel= "AppleViewGlobalData.applePayMerchantId ";
  static const String CountryCode="SA";
  static const String CurrencyCode="SAR";
  static const String channel="Hyperpay.demo.fultter/channel";
  static getLang() {
    if (Platform.isIOS) {
      return  "ar";
    } else {
      return "ar_AR";
    }
  }
}
