#import "PaymentPlugin.h"
#if __has_include(<payment/payment-Swift.h>)
#import <payment/payment-Swift.h>

#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hyperpay_plugin-Swift.h"
#endif

@implementation PaymentPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPaymentPlugin registerWithRegistrar:registrar];
}
@end
