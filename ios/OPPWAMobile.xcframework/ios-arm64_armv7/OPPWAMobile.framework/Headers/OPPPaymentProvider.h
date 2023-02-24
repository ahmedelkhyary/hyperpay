//
// Copyright (c) $$year$$ by ACI Worldwide, Inc.
// All rights reserved.
//
// This software is the confidential and proprietary information
// of ACI Worldwide Inc ("Confidential Information"). You shall
// not disclose such Confidential Information and shall use it
// only in accordance with the terms of the license agreement
// you entered with ACI Worldwide Inc.
//

@import Foundation;
@import PassKit;
@class OPPTransaction;
@class OPPPaymentParams;
@class OPPCheckoutInfo;
@class OPPThreeDSConfig;
@class OPPBinInfo;

/// An enumeration for the various provider modes.
typedef NS_ENUM(NSInteger, OPPProviderMode) {
    /// Sandbox environment for testing integration.
    OPPProviderModeTest,
    /// Live server for real transactions.
    OPPProviderModeLive
};

/// An enumeration for server endpoint domain.
typedef NS_ENUM(NSInteger, OPPProviderDomain) {
    /// oppwa.com for Live server mode, test.oppwa.com for Sandbox mode.
    OPPProviderDomainDefault,
    /// eu-prod.oppwa.com for Live server mode, eu-test.oppwa.com for Sandbox mode.
    OPPProviderDomainEU
};

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol to handle 3-D Secure workflow.
 */
@protocol OPPThreeDSEventListener <NSObject>
@optional

/**
 Called before initialization of `OPPThreeDSService`.
 Use this callback to provide `OPPThreeDSConfig` configurations applied during `OPPThreeDSService` initialization phase.
 @param completion The completion block you should call to continue 3-D Secure transaction.
 */
- (void)onThreeDSConfigRequiredWithCompletion:(void (^)(OPPThreeDSConfig *config))completion;

/**
 Called before starting the authentication process of 3-D Secure transaction.
 Use this callback to provide UINavigationController, which will be used for 3-D Secure challenge process.
 @param completion The completion block you should call to continue 3-D Secure transaction.
 */
- (void)onThreeDSChallengeRequiredWithCompletion:(void (^)(UINavigationController *navController))completion;

@end

/**
 Defines the methods and properties of the payment provider. Use the factory method `+paymentProviderWithMode:` to instantiate a new provider.
*/
@interface OPPPaymentProvider : NSObject

/// @name Properties

/**
 Determines the type of Server to use. Transactions to the LIVE server come with fees attached.
*/
@property (nonatomic) OPPProviderMode mode;

/**
 Determines Server endpoint domain.
*/
@property (nonatomic) OPPProviderDomain domain;

/**
 Delegate for processing the 3-D Secure transaction.
 */
@property (nonatomic, weak, nullable) id<OPPThreeDSEventListener> threeDSEventListener;

/// @name Factory methods

/**
 Factory method to obtain a new provider.
 @param mode Determines the type of Server to use. Transactions to the LIVE server come with fees attached.
 @return An `OPPPaymentProvider` which can be used to process transactions.
*/
+ (instancetype)paymentProviderWithMode:(OPPProviderMode)mode;

/**
 Factory method to obtain a new provider.
 @param mode Determines the type of Server to use. Transactions to the LIVE server come with fees attached.
 @param domain Determines Server endpoint domain.
 @return An `OPPPaymentProvider` which can be used to process transactions.
*/
+ (instancetype)paymentProviderWithMode:(OPPProviderMode)mode andDomain:(OPPProviderDomain)domain;


/// @name Process transaction

/**
 On sending a transaction, it is performed asynchronously using an `NSURLSession` to communicate with the Server. Depending on the endpoint the transaction will be submitted or registered only without making the payment.
 
 @param transaction The transaction to be sent.
 @param endpoint The endpoint which will be used for processing transaction. The endpoint must start with a `"/"`.
 @param completionHandler A block executed when the transaction is sent.
 */
- (void)sendTransaction:(OPPTransaction *)transaction toEndpoint:(NSString *)endpoint completionHandler:(void (^)(OPPTransaction *transaction, NSError * _Nullable error))completionHandler;

/**
 On submitting a transaction, it is performed asynchronously using an `NSURLSession` to communicate with the Server. Depending on the concrete type of the transaction, various calls to the server are necessary to ensure proper processing. Submitting means that the transaction is sent to the server, where it will cause a debit of the given amount on the account specified in the `OPPTransaction`'s `OPPPaymentParams`.
 
 @param transaction The transaction to be submitted.
 @param completionHandler A block executed when the transaction is submitted.
*/
- (void)submitTransaction:(OPPTransaction *)transaction completionHandler:(void (^)(OPPTransaction *transaction, NSError * _Nullable error))completionHandler;

/**
 On storing a payment data, it is performed asynchronously using an `NSURLSession` to communicate with the Server. The method creates a just registration separate from any later payment.
 
 @param transaction The transaction to be registered.
 @param completionHandler A block executed when the transaction is registered.
 */
- (void)registerTransaction:(OPPTransaction *)transaction completionHandler:(void (^)(OPPTransaction *transaction, NSError * _Nullable error))completionHandler;

/// @name Request checkout info
/**
 Requests checkout details such as amount, currency and tokens from the Server by checkout ID.
 Request is performed asynchronously using an `NSURLSession`.
 
 @param checkoutID The checkout ID of a transaction.
 @param completionHandler The completion block will be invoked once the response in received. On success, you will receive an instance of `OPPCheckoutInfo`; on failure, an error.
 */
- (void)requestCheckoutInfoWithCheckoutID:(NSString *)checkoutID completionHandler:(void (^)(OPPCheckoutInfo * _Nullable checkoutInfo, NSError * _Nullable error))completionHandler;

/// @name Request URLs for payment brand logos
/**
 Requests logo URLs for specified payment brands.
 Request is performed asynchronously using an `NSURLSession`.
 
 @param paymentBrands The list of payment brands to get logos from the Server.
 @param completionHandler The completion block will be invoked once the response in received. On success, you will receive a dictionary with URLs in format `<paymentBrand: URL>`; on failure, an error.
 */
- (void)requestLogoURLsForPaymentBrands:(NSArray<NSString *> *)paymentBrands completionHandler:(void (^)(NSDictionary<NSString *, NSURL *> * _Nullable URLs, NSError * _Nullable error))completionHandler;

/// @name Request `OPPBinInfo` for provided card bin
/**
@note If you are using core SDK, please request checkout info by calling `-[OPPPaymentProvider requestCheckoutInfoWithCheckoutID:completionHandler:]` before requestBinInfo call. Checkout info call is essential part of the flow, error will be thrown otherwise.
 
@param checkoutID The checkout ID of a transaction.
@param bin First 6 or more digits of the card number.
@param completionHandler The completion block will be invoked once the response in received. On success, you will receive an instance of `OPPBinInfo`; on failure, an error.
 */
- (void)requestBinInfoWithCheckoutID:(NSString *)checkoutID
                                 bin:(NSString *)bin
                   completionHandler:(void (^)(OPPBinInfo * _Nullable binInfo,
                                               NSError * _Nullable error))completionHandler;

/// @name Apple Pay methods
/**
 Determine whether this device can process Apple Pay payment requests using specific payment request. Your application should confirm that the user can make payments before attempting to authorize a payment. Your application may also want to alter its appearance or behavior when the user is not allowed to make payments.
 
 @param request The return value of this method depends on the `supportedNetworks` property of this payment request.
 
 @return `YES` if the user can authorize payments on this device using the payment request. `NO` if the user cannot authorize payments on these networks or if the user is restricted from authorizing payments.
 */
+ (BOOL)canSubmitPaymentRequest:(PKPaymentRequest *)request;

/**
 Whether or not this device is capable of using Apple Pay. This checks both whether the user is running an iPhone 6/6+ or later, iPad Air 2 or later, or iPad mini 3 or later, as well as whether or not they have stored any cards in Apple Pay on their device.
 
 @return Whether or not the user is currently able to pay with Apple Pay.
 */
+ (BOOL)deviceSupportsApplePay;

/**
 A convenience method to return a `PKPaymentRequest` with sane default values. You will still need to configure the `paymentSummaryItems` property to indicate what the user is purchasing.
 
 @param merchantIdentifier Your Apple Merchant ID, as obtained at https://developer.apple.com/account/ios/identifiers/merchant/merchantCreate.action
 @param countryCode The merchant's ISO country code. We suggest using the country where your business is located.
 @return A `PKPaymentRequest` with proper default values.
 */
+ (PKPaymentRequest *)paymentRequestWithMerchantIdentifier:(NSString *)merchantIdentifier countryCode:(NSString *)countryCode;

/// @name Device authentication

/**
 A convenience method to check if Touch ID, Face ID or passcode are set on user device.
 @return `NO` if neither Touch ID/Face ID nor passcode are set, otherwise `YES`.
 */
+ (BOOL)isDeviceAuthenticationAvailable;


/// @name Deprecated

/**
 Requests list of payment brands for provided card bin.
 Request is performed asynchronously using an NSURLConnection.
 
 @note If you are using core SDK, please request checkout info by calling `-[OPPPaymentProvider requestCheckoutInfoWithCheckoutID:completionHandler:]` before requestPaymentBrandsForBin call. Checkout info call is essential part of the flow, error will be thrown otherwise.
 @param bin First 6 or more digits of the card number.
 @param completionHandler The completion block will be invoked once the response in received.
 @warning **Deprecated:** Use `-requestBinInfoWithCheckoutID:bin:completionHandler:` instead.
 */
- (void)requestPaymentBrandsForBin:(NSString *)bin
                        checkoutID:(NSString *)checkoutID
                 completionHandler:(void (^)(NSArray <NSString *> * _Nullable paymentBrands,
                                             NSError * _Nullable error))completionHandler DEPRECATED_MSG_ATTRIBUTE("- Use -requestBinInfoWithCheckoutID:bin:completionHandler: instead.");

@end
NS_ASSUME_NONNULL_END
