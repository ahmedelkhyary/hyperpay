// import 'package:flutter_test/flutter_test.dart';
// import 'package:payment/payment.dart';
// import 'package:payment/payment_platform_interface.dart';
// import 'package:payment/payment_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockPaymentPlatform
//     with MockPlatformInterfaceMixin
//     implements PaymentPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final PaymentPlatform initialPlatform = PaymentPlatform.instance;
//
//   test('$MethodChannelPayment is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelPayment>());
//   });
//
//   test('getPlatformVersion', () async {
//     Payment paymentPlugin = Payment();
//     MockPaymentPlatform fakePlatform = MockPaymentPlatform();
//     PaymentPlatform.instance = fakePlatform;
//
//     expect(await paymentPlugin.getPlatformVersion(), '42');
//   });
// }
