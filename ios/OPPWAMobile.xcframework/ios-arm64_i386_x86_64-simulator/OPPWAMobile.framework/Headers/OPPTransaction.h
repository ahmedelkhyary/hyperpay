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

#import <Foundation/Foundation.h>
@class OPPTransactionProcessor;
@class OPPPaymentParams;
@class OPPThreeDS2Info;
@class OPPYooKassaInfo;

/// An enumeration for the various types of transaction.
typedef NS_ENUM(NSInteger, OPPTransactionType) {
    /// The synchronous transaction.
    OPPTransactionTypeSynchronous,
    /// The asynchronous transaction.
    OPPTransactionTypeAsynchronous,
    /// The transaction is undefined.
    OPPTransactionTypeUndefined
};

/**
 Class to encapsulate the parameters needed for performing transaction.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPTransaction : NSObject

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates and returns transaction initialized with payment params.
 
 @param paymentParams The payment parameters for transaction. Must not be `nil`.
 */
+ (instancetype)transactionWithPaymentParams:(OPPPaymentParams *)paymentParams;

/**
 Creates and returns transaction initialized with payment params.
 
 @param paymentParams The payment parameters for transaction. Must not be `nil`.
 */
- (instancetype)initWithPaymentParams:(OPPPaymentParams *)paymentParams NS_DESIGNATED_INITIALIZER;

/// @name Properties

/** 
 The parameters representing a specific payment method that are kept as an `OPPPaymentParams` object.
 */
@property (nonatomic, readonly) OPPPaymentParams *paymentParams;

/**
 The type of the transaction.
 */
@property (nonatomic, readonly) OPPTransactionType type;

/// The URL to the receiver system (e.g. 3-D Secure, PayPal) that the shopper should be forwarded to. The property has `nil` value on synchronous transaction.
@property (nonatomic, nullable) NSURL *redirectURL;

/**
 Relative path to get status of transaction.
 @note The property is returned ONLY from `OPPCheckoutProvider` methods. If you are using core SDK, please request checkout info to get `checkoutInfo.resourcePath` by calling `-[OPPPaymentProvider requestCheckoutInfoWithCheckoutID:completionHandler:]`.
 */
@property (nonatomic, copy, nullable) NSString *resourcePath;

/// 3-D Secure 2 response parameters.
@property (nonatomic, readonly, nullable) OPPThreeDS2Info *threeDS2Info;

/// YooKassa response parameters.
@property (nonatomic, readonly, nullable) OPPYooKassaInfo *yooKassaInfo;

/// The URL which posts threeDSMethodData to the ACS. It should be opened in a hidden iframe.
 @property (nonatomic, nullable) NSURL *threeDS2MethodRedirectURL;

/**
 Dictionary for holding brand-specific parameters like:
 @see `OPPTransactionKlarnaInlineClientTokenKey`, `OPPTransactionKlarnaInlineClientCallbackUrlKey`, `OPPTransactionKlarnaInlineClientFailureCallbackUrlKey`, `OPPTransactionKlarnaInlineInitialTransactionIdKey`, `OPPTransactionAlipaySignedOrderInfoKey`.
 */
@property (nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *brandSpecificInfo;

/**
Constant for a key to get Klarna Payments client token value from the transaction response.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionKlarnaInlineClientTokenKey;

/**
Constant for a key to get Klarna Payments callback URL value from the transaction response.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionKlarnaInlineClientCallbackUrlKey;

/**
Constant for a key to get Klarna Payments failure callback URL from the transaction response.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionKlarnaInlineClientFailureCallbackUrlKey;

/**
Constant for a key to get Klarna Payments initial transaction id from the transaction response.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionKlarnaInlineInitialTransactionIdKey;

/**
Constant for a key to get Alipay seller's order information which should be forwarded to Alipay native SDK.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionAlipaySignedOrderInfoKey;

/**
Constant for a key to get Bancontact app scheme URL to redirect to the Bancontact app.
*/
FOUNDATION_EXPORT NSString *const OPPTransactionBancontactLinkAppSchemeUrlKey;

@end
NS_ASSUME_NONNULL_END
