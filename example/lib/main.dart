import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:hyperpay_plugin/model/custom_ui.dart';
import 'package:hyperpay_plugin/model/custom_ui_stc.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';

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

  late FlutterHyperPay flutterHyperPay ;
  @override
  void initState() {
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl,
      paymentMode:  PaymentMode.test,
      lang: InAppPaymentSetting.getLang(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("pay with ready ui".toUpperCase() , style: const TextStyle(fontSize: 20 , color: Colors.red),),
            InkWell( onTap: ()async{
              String? checkoutId = await getCheckOut();
              if(checkoutId !=null) {
                /// Brands Names [ VISA , MASTER , MADA , STC_PAY , APPLEPAY]
                payRequestNowReadyUI( brandsName: [ "VISA" , "MASTER" , "MADA" ,"PAYPAL", "STC_PAY" , "APPLEPAY"], checkoutId: checkoutId);
              }
              }, child: const Text("[VISA,MASTER,MADA,STC_PAY,APPLEPAY]" , style: TextStyle(fontSize: 20),)),

            const Divider(),
            Text("pay with custom ui".toUpperCase() , style: const TextStyle(fontSize: 20 , color: Colors.red),),
            InkWell( onTap: ()async{
              String? checkoutId = "D4BA27E10287D21E24789A07B044CA12.uat01-vm-tx02";
              if(checkoutId !=null) {
                // "VISA" 4111111111111111
                // "MASTER" 5541805721646120
                // "MADA" "4464040000000007"
                payRequestNowCustomUi(brandName: "VISA", checkoutId: checkoutId, cardNumber: "4111111111111111");
              }
              }, child: const Text("CUSTOM_UI" , style: TextStyle(fontSize: 20),)),

            const Divider(),
            Text("pay with custom ui stc".toUpperCase() , style: const TextStyle(fontSize: 20 , color: Colors.red),),
            InkWell( onTap: ()async{
              String? checkoutId = await getCheckOut();
              if(checkoutId !=null) {
                payRequestNowCustomUiSTCPAY(checkoutId: checkoutId, phoneNumber: "0588987147");
              }

            }, child: const Text("STC_PAY" , style: TextStyle(fontSize: 20),)),

          ],
        ),
      ),
    );
  }

  /// URL TO GET CHECKOUT ID FOR TEST
  /// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php

  Future<String?> getCheckOut() async {
    final url = Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      dev.log(json.decode(response.body)['id'].toString(), name: "checkoutId");
      return json.decode(response.body)['id'];
    }else{
      dev.log(response.body.toString(), name: "STATUS CODE ERROR");
      return null;
    }
  }

  payRequestNowReadyUI(
      {required List<String> brandsName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
            brandsName: brandsName ,
            checkoutId: checkoutId,
            merchantIdApplePayIOS: InAppPaymentSetting.merchantId,
            countryCodeApplePayIOS: InAppPaymentSetting.countryCode,
            companyNameApplePayIOS: "Test Co",
            themColorHexIOS: "#000000" ,// FOR IOS ONLY
            setStorePaymentDetailsMode: true // store payment details for future use
            ),
      );

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
  }

  payRequestNowCustomUi(
      {required String brandName, required String checkoutId , required String cardNumber}) async {
    PaymentResultData paymentResultData;

    paymentResultData = await flutterHyperPay.customUICards(
      customUI: CustomUI(
        brandName: brandName,
        checkoutId: checkoutId,
        cardNumber: cardNumber,
        holderName: "test name",
        month: "01",
        year: "2025",
        cvv: "123",
        enabledTokenization: false, // default
      ),
    );

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
  }

  payRequestNowCustomUiSTCPAY(
      {required String phoneNumber, required String checkoutId}) async {
    PaymentResultData paymentResultData;

    paymentResultData = await flutterHyperPay.customUISTC(
      customUISTC: CustomUISTC(
          checkoutId: checkoutId,
          phoneNumber: phoneNumber
      ),
    );

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
  }
}

class InAppPaymentSetting {
  static const String shopperResultUrl= "com.testpayment.payment";
  static const String merchantId= "MerchantId";
  static const String countryCode="SA";
  static getLang() {
    if (Platform.isIOS) {
      return  "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}