# HyperPay SDK Plugin

The HyperPay platform offers a complete, easy-to-use guide to enable seamless integration of our end-to-end payment gateway for mobile and desktop browsers. Through a unified API, you can enable and gain access to all platform features. Choose one of the options below to quickly get started

[![pub package](https://img.shields.io/badge/Release-3.0.0%20Pub%20dev-blue)](https://pub.dev/packages/hyperpay_plugin)
[![Discord](https://img.shields.io/badge/Discord-JOIN-blue?logo=discord)](https://discord.gg/T8TyGxpGBS)
[![GitHub](https://img.shields.io/badge/Github-Link-blue?logo=github)](https://github.com/ahmedelkhyary/hyperpay)
[![License](https://img.shields.io/badge/license-MIT-purple.svg)](https://pub.dev/packages/hyperpay_plugin/license)


## Support ReadyUI , CustomUI
- **VISA** **,** **MasterCard**
- **STC**
- **Apple Pay**
- **MADA** *( Saudi Arabia )*

### Android Setup

1. Open `android/app/build.gradle` and add the following lines
   &NewLine;

```
    implementation(name: "oppwa.mobile-release", ext: 'aar')
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
The `Scheme` field must match the `InAppPaymentSetting.shopperResultUrl` field.

`It's used when making a payment outside the app (Like open browser) and back into the app`



### IOS Setup
1. Open Podfile, and paste the following inside of it:
   &NewLine;

```ruby
pod 'hyperpay_sdk', :git => 'https://github.com/ahmedelkhyary/hyperpay_sdk.git'
$static_framework = ['hyperpay_plugin']
pre_install do |installer|
  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
  installer.pod_targets.each do |pod|
      if $static_framework.include?(pod.name)
        def pod.build_type;
          Pod::BuildType.static_library
        end
      end
    end
end
```

2. Add `Url Scheme` to the list of bundle identifiers.
   The `Url Scheme` field must match the `InAppPaymentSetting.shopperResultUrl` field.

<br /><img src="https://user-images.githubusercontent.com/70061912/222664709-0744b798-ba1d-47e4-917d-c05e803f89ef.PNG" atl="Xcode URL type" width="700"/>





### Setup HyperPay Environment Configuration
define instanse of `FlutterHyperPay`
```dart
late FlutterHyperPay flutterHyperPay ;
flutterHyperPay = FlutterHyperPay(
shopperResultUrl: InAppPaymentSetting.shopperResultUrl, // return back to app
paymentMode:  PaymentMode.test, // test or live
lang: InAppPaymentSetting.getLang(),
);

```
create a method to get the checkoutId
```
  /// URL TO GET CHECKOUT ID FOR TEST
  /// http://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php
  /// Brands Names [ VISA , MASTER , MADA , STC_PAY , APPLEPAY]

getCheckOut() async {
    final url = Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      payRequestNowReadyUI(
        checkoutId: json.decode(response.body)['id'],
        brandsName: [ "VISA" , "MASTER" , "MADA" ,"PAYPAL", "STC_PAY" , "APPLEPAY"]);
    }else{
      dev.log(response.body.toString(), name: "STATUS CODE ERROR");
    }
  }
  ```
If you want using `readyUI` send checkoutId and List of `brandsName` to Plugin

Brands Names support [ VISA , MASTER , MADA , STC_PAY , APPLEPAY]
```
  payRequestNowReadyUI(
      {required List<String> brandsName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
      paymentResultData = await flutterHyperPay.readyUICards(
        readyUI: ReadyUI(
            brandsName: brandsName ,
            checkoutId: checkoutId,
            merchantIdApplePayIOS: InAppPaymentSetting.merchantId, // applepay
            countryCodeApplePayIOS: InAppPaymentSetting.countryCode, // applePay
            companyNameApplePayIOS: "Test Co", // applePay
            themColorHexIOS: "#000000" ,// FOR IOS ONLY
            setStorePaymentDetailsMode: true // store payment details for future use
            ),
      );
  }


```
If you want using `CustomUI` 
```
 payRequestNowCustomUi(
      {required String brandName, required String checkoutId}) async {
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.customUICards(
      customUI: CustomUI(
        brandName: brandName,
        checkoutId: checkoutId,
        cardNumber: "5541805721646120",
        holderName: "test name",
        month: 12,
        year: 2023,
        cvv: 123,
        enabledTokenization: false, // default
      ),
    );
  }
```
`STC CustomUI` - now for android only next release we will support IOS
```
  // STC_PAY
    payRequestNowCustomUiSTCPAY(
      {required String phoneNumber, required String checkoutId}) async {
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.customUISTC(
      customUISTC: CustomUISTC(
          checkoutId: checkoutId,
          phoneNumber: phoneNumber
      ),
    );
  }
```

get check the payment status after request
```
    if (paymentResultData.paymentResult == PaymentResult.success ||
        paymentResultData.paymentResult == PaymentResult.sync) {
      // do something
    }
```
`ReadyUI`
change color in `android` platform
open `android/app/src/main/res/values` and add the following lines

```
    <!--    DEFAULT COLORS YOU CAN OVERRIDE IN YOUR APP-->
    <color name="headerBackground">#000000</color>
    <color name="cancelButtonTintColor">#FFFFFF</color>
    <color name="listMarkTintColor">#000000</color>
    <color name="cameraTintColor">#000000</color>
    <color name="checkboxButtonTintColor">#000000</color>
```
`payment setting`
```
  class InAppPaymentSetting {
   // shopperResultUrl : this name must like scheme in intent-filter , url scheme in xcode
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
```

[`MerchantId apple pay Setup click here this steps to create and verify apple pay and domain`](https://github.com/ahmedelkhyary/applepay_merchantId_config) 