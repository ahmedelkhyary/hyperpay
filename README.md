# HyperPay SDK Plugin 

The HyperPay platform offers a complete, easy-to-use guide to enable seamless integration of our end-to-end payment gateway for mobile and desktop browsers. Through a unified API, you can enable and gain access to all platform features. Choose one of the options below to quickly get started

#### [Official Website](https://www.hyperpay.com/integration-guides/)

[![pub package](https://img.shields.io/badge/pub-1.0.0-blue)](https://pub.dev/packages/hyperpay_plugin)


## Support ReadyUI
- **VISA** **,** **MasterCard**
- **STC**
- **Apple Pay**
- **MADA** *( Saudi Arabia )*

### Android Setup

1. Open `android/app/build.gradle` and add the following lines 
&NewLine;

```
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation(name: "oppwa.mobile-4.9.0-release", ext: 'aar')
    debugImplementation(name: "ipworks3ds_sdk", ext: 'aar')
    releaseImplementation(name: "ipworks3ds_sdk_deploy", ext: 'aar')
    implementation "com.google.android.material:material:1.6.1"
    implementation "androidx.appcompat:appcompat:1.5.1"
    implementation 'com.google.android.gms:play-services-wallet:19.1.0'
    implementation "androidx.browser:browser:1.4.0"
```
2. Open `app/build.gradle` and make sure that the `minSdkVersion` is **21**
&NewLine;

3. Open your `AndroidManifest.xml`, and put `intent-filter` inside `activity`.
&NewLine;


```
<application
  <activity
        <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.BROWSABLE" />
                <category android:name="android.intent.category.DEFAULT" />

                <category android:name="android.intent.category.LAUNCHER" />
                <data android:scheme="com.testpayment.payment" />
            </intent-filter>
  </activity>
</application>
        
```
#### Note about Intent-filter scheme
 `It's used when making a payment outside the app (Like open browser) and back into the app` 
 
 

### IOS Setup
We will release it in the next version



### Setup HyperPay Environment Configuration

```dart
late FlutterHyperPay flutterHyperPay ;
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl: InAppPaymentSetting.shopperResultUrl, // For Android
      paymentMode:  PaymentMode.test,
      lang: InAppPaymentSetting.getLang(),
    );

```

```
  /// URL TO GET CHECKOUT ID FOR TEST
  /// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php

getCheckOut() async {
    payRequestNow(checkoutId: '629D8A95DE267040C10D29E558F8BE37.uat01-vm-tx04', cardName: "VISA");
  }

payRequestNow({required String cardName, required String checkoutId}) async {

    PaymentResultData paymentResultData;
    if (cardName.toLowerCase() ==
        InAppPaymentSetting.applePay.toLowerCase()) {
      paymentResultData = await flutterHyperPay.payWithApplePay(
        applePay: ApplePay(
          /// ApplePayBundel refer to Merchant ID
            applePayBundel: InAppPaymentSetting.merchantId,
            checkoutId: checkoutId,
            countryCode: InAppPaymentSetting.countryCode,
            currencyCode: InAppPaymentSetting.currencyCode),
      );
    } else {
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
          brandName: cardName,
          checkoutId: checkoutId,
          setStorePaymentDetailsMode: false,
        ),
      );
    }

    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }

  }

```

```
  class InAppPaymentSetting {
  static const String applePay="APPLEPAY";
  static  String shopperResultUrl= "com.testpayment.payment"; // this name must like scheme in intent-filter
  static  String merchantId= "Your MerchantId";
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
```



