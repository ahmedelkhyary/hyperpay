import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

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
            InkWell( onTap: (){getCheckOut(brandName: "VISA");}, child: const Text("VISA" , style: TextStyle(fontSize: 20),)),
            InkWell( onTap: (){getCheckOut(brandName: "MASTER");}, child: const Text("MASTER" , style: TextStyle(fontSize: 20),)),
            InkWell( onTap: (){getCheckOut(brandName: "MADA");}, child: const Text("MADA" , style: TextStyle(fontSize: 20),)),
            InkWell( onTap: (){getCheckOut(brandName: "STC_PAY");}, child: const Text("STC_PAY" , style: TextStyle(fontSize: 20),)),
            Platform.isIOS
                ? InkWell( onTap: (){getCheckOut(brandName: "APPLEPAY");}, child: const Text("APPLEPAY" , style: TextStyle(fontSize: 20),))
                : Container(),

            const Divider(),
            Text("pay with custom ui".toUpperCase() , style: const TextStyle(fontSize: 20 , color: Colors.red),),
            InkWell( onTap: (){getCheckOut(brandName: "VISA" , payWithReadyUi: false);}, child: const Text("VISA" , style: TextStyle(fontSize: 20),)),
            InkWell( onTap: (){getCheckOut(brandName: "MASTER" , payWithReadyUi: false);}, child: const Text("MASTER" , style: TextStyle(fontSize: 20),)),
            InkWell( onTap: (){getCheckOut(brandName: "MADA" , payWithReadyUi: false);}, child: const Text("MADA" , style: TextStyle(fontSize: 20),)),
            const Divider(),
            Text("pay with custom ui stc".toUpperCase() , style: const TextStyle(fontSize: 20 , color: Colors.red),),
            InkWell( onTap: (){getCheckOut(brandName: "STC_PAY");}, child: const Text("STC_PAY" , style: TextStyle(fontSize: 20),)),

          ],
        ),
      ),
    );
  }

  /// URL TO GET CHECKOUT ID FOR TEST
  /// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php
  /// Brands Names [ VISA , MASTER , MADA , STC_PAY , APPLEPAY]

  getCheckOut({required String brandName , bool payWithReadyUi = true }) async {
    final url = Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if(brandName == "STC_PAY"){
        payRequestNowCustomUiSTCPAY(checkoutId: json.decode(response.body)['id'], phoneNumber: "0588987147");
      }else{
        if(payWithReadyUi) {
          payRequestNowReadyUI(checkoutId: json.decode(response.body)['id'], cardName: brandName);
        }else{
          payRequestNowCustomUi(checkoutId: json.decode(response.body)['id'], cardName: brandName);
        }
      }

    }else{
      dev.log(response.body.toString(), name: "STATUS CODE ERROR");
    }
  }

  payRequestNowReadyUI(
      {required String cardName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
    if (cardName.toLowerCase() == InAppPaymentSetting.applePay.toLowerCase()) {
      paymentResultData = await flutterHyperPay.payWithApplePay(
        applePay: ApplePay(
          /// ApplePayBundel refer to Merchant ID
            applePayBundel: InAppPaymentSetting.merchantId,
            checkoutId: checkoutId,
            countryCode: InAppPaymentSetting.countryCode,
            currencyCode: InAppPaymentSetting.currencyCode,
            themColorHexIOS: "#000000", // FOR IOS ONLY
            companyName: "Test Co"),
      );
    } else {
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
            brandName: cardName,
            checkoutId: checkoutId,
            setStorePaymentDetailsMode: false,
            themColorHexIOS: "#000000" // FOR IOS ONLY
            ),
      );
    }

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
  }

  payRequestNowCustomUi(
      {required String cardName, required String checkoutId}) async {
    PaymentResultData paymentResultData;

    paymentResultData = await flutterHyperPay.customUICards(
      customUI: CustomUI(
        brandName: cardName,
        checkoutId: checkoutId,
        cardNumber: "5541805721646120",
        holderName: "test name",
        month: 12,
        year: 2023,
        cvv: 123,
        enabledTokenization: false, // default
        payTypeStoredCard: false // default
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
  static const String applePay="APPLEPAY";
  static const String shopperResultUrl= "com.testpayment.payment";
  static const String merchantId= "MerchantId";
  static const String countryCode="SA";
  static const String currencyCode="SAR";
  static getLang() {
    if (Platform.isIOS) {
      return  "en"; // ar
    } else {
      return "en_US"; // ar_AR
    }
  }
}