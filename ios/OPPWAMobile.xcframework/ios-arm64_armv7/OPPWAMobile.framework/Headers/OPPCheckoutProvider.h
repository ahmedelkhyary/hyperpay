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
@class OPPPaymentProvider;
@class OPPTransaction;
@class OPPCheckoutSettings;
@class OPPCheckoutProvider;
@class OPPApplePayRequestAuthorizationResult;
@class OPPApplePayRequestShippingContactUpdate;
@class OPPApplePayRequestShippingMethodUpdate;
@protocol OPPCheckoutProviderDelegate;

NS_ASSUME_NONNULL_BEGIN

/**
 A protocol for additional checkout callbacks.
 */
@protocol OPPCheckoutProviderDelegate <NSObject>
@optional

/// @name Validation methods

/**
 Called before submitting a transaction to the Server.
 Use this callback to recreate checkout for specific payment brand or abort transaction.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 @param transaction The transaction with masked sensitive data.
 @param completion The completion block you should call to continue submitting transaction or abort it. In case of abortion checkout will be closed with error `OPPErrorCodeTransactionAborted`.
 */
- (void)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider continueSubmitting:(OPPTransaction *)transaction completion:(void (^)(NSString * _Nullable checkoutID, BOOL abort))completion;

/**
 Called when card holder text field was changed or pressed Pay button on the payment detail view.
 Use this callback to override the internal card holder validation.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 @param cardHolder The card holder value.
 @return `YES` if the card holder is valid, otherwise `NO`.
 */
- (BOOL)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider validateCardHolder:(nullable NSString *)cardHolder;

/// @name Safari services methods

/**
 Called when the user taps the 'Done' button on SFSafariViewController.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 */
- (void)checkoutProviderDidFinishSafariViewController:(OPPCheckoutProvider *)checkoutProvider;

/// @name Apple Pay methods

/**
 Called when a new shipping method was selected.
 The delegate must invoke the completion block with an updated array of `PKPaymentSummaryItem` objects.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 @param shippingMethod The shipping method for this transaction.
 @param completion The completion block you should call to update the shipping costs based on the shipping method.
*/
- (void)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider applePayDidSelectShippingMethod:(PKShippingMethod *)shippingMethod handler:(void (^)(OPPApplePayRequestShippingMethodUpdate *update))completion;

/**
 Called when a new shipping address was selected.
 The delegate must invoke the completion block with an updated array of `PKPaymentSummaryItem` objects.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 @param contact The contact information needed for shipping.
 @param completion The completion block you should call to update the shipping address.
 */
- (void)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider applePayDidSelectShippingContact:(PKContact *)contact handler:(void (^)(OPPApplePayRequestShippingContactUpdate *update))completion;


/**
 Called when the payment request was authorized.
 The delegate must invoke the completion block with an appropriate authorization status.
 @param checkoutProvider The instance of `OPPCheckoutProvider` that is calling delegate method.
 @param payment The result of authorizing a payment request and contains payment information, encrypted in the payment token.
 @param completion The completion block you should call with an appropriate authorization status.
 */
- (void)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider applePayDidAuthorizePayment:(PKPayment *)payment handler:(void (^)(OPPApplePayRequestAuthorizationResult *result))completion;

@end


/**
 Abstract class for displaying an in-App payment page.
 */
@interface OPPCheckoutProvider : NSObject

/// @name Properties

/**
 Checkout provider delegate.
 */
@property (nonatomic, weak) id<OPPCheckoutProviderDelegate> delegate;

/// @name Initialization

/**
 Factory method to generate an `OPPCheckoutProvider` used for displaying an in-App payment pages.
 @param provider The OPPPaymentProvider which is used for performing the transaction once all the data from the user is collected.
 @param checkoutID The checkout Id of the transaction. Must be not `nil` or empty.
 @param settings The `OPPCheckoutSettings` used for these payment pages. These settings are provided to customize the appearance and functionality of the payment pages. If `nil`, default settings will be created.

 @return Returns an `OPPCheckoutProvider` for displaying in-App payment pages. Returns `nil` if `provider` or `checkoutID` are not set.
 */
+ (nullable instancetype)checkoutProviderWithPaymentProvider:(OPPPaymentProvider *)provider checkoutID:(NSString *)checkoutID settings:(nullable OPPCheckoutSettings *)settings;

/**
 Designated initializer method to generate an `OPPCheckoutProvider` used for displaying an in-App payment pages.
 @param provider The OPPPaymentProvider which is used for performing the transaction once all the data from the user is collected.
 @param checkoutID The checkout Id of the transaction. Must be not `nil` or empty.
 @param settings The `OPPCheckoutSettings` used for these payment pages. These settings are provided to customize the appearance and functionality of the payment pages. If `nil`, default settings will be created.
 @return Returns an `OPPCheckoutProvider` for displaying in-App payment pages. Returns `nil` if `provider` or `checkoutID` are not set.
 */
- (nullable instancetype)initWithPaymentProvider:(OPPPaymentProvider *)provider checkoutID:(NSString *)checkoutID settings:(nullable OPPCheckoutSettings *)settings;

/// @name Presenting checkout

/**
 Opens an in-App payment page for collecting user input and submitting a transaction. First the list of payment methods from the checkout settings will be displayed.
 @param completionHandler A block executed when the transaction is completed. You need to send the request to your server to get the transaction status.
 @param cancelHandler A block executed if the user closes the payment page prematurely.
 */
- (void)presentCheckoutForSubmittingTransactionCompletionHandler:(void (^)(OPPTransaction * _Nullable transaction, NSError * _Nullable error))completionHandler
                                                   cancelHandler:(void (^ _Nullable )(void))cancelHandler;

/**
 Opens an in-App payment page for collecting user input and submitting a transaction.
 Payment form for the choosen payment method will be opened. If no user input is required in app (e.g. PayPal), shopper will be redirected directly to the issuer web page.
 @param paymentBrand The payment brand for transaction.
 @param loadingHandler A block executed whenever SDK sends request to the server or receives the response. You can start or stop loading animation based on `inProgress` parameter.
 @param completionHandler A block executed when the transaction is completed. You need to send the request to your server to get the transaction status.
 @param cancelHandler A block executed if the user closes the payment page prematurely.
 */
- (void)presentCheckoutWithPaymentBrand:(NSString *)paymentBrand
                         loadingHandler:(void (^ _Nullable )(BOOL inProgress))loadingHandler
                      completionHandler:(void (^)(OPPTransaction * _Nullable transaction, NSError * _Nullable error))completionHandler
                          cancelHandler:(void (^ _Nullable )(void))cancelHandler;

/**
 Closes the in-App payment page. The delegate is not informed if this method is being called.
 @param animated Specifies whether the payment page should be dismissed using an animation or immediately without an animation.
 @param completion The completion handler, if provided, will be invoked after the checkout screen will be dismissed.
 */
- (void)dismissCheckoutAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion;

@end
NS_ASSUME_NONNULL_END
