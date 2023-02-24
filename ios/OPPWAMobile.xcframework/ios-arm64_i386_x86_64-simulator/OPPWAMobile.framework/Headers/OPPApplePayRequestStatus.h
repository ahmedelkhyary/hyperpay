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

NS_ASSUME_NONNULL_BEGIN

/**
 Class that reports the status code and errors that you return when a payment is authorized.
 */
@interface OPPApplePayRequestAuthorizationResult : NSObject

/// @name Initialization

/**
 Initializes the result with the status code and list of errors.
 @param status Payment authorization general status.
 @param errors List of errors in the Apple Pay form (available for iOS 11 and higher).
 */
- (instancetype)initWithStatus:(PKPaymentAuthorizationStatus)status
                        errors:(nullable NSArray<NSError *> *)errors NS_DESIGNATED_INITIALIZER;

/// @name Properties

/**
 Payment authorization general status.
 */
@property (nonatomic) PKPaymentAuthorizationStatus status;

/**
 Any errors that applied. These errors will be displayed to the user to correct (available for iOS 11 and higher).
 Errors should be ordered from most to least serious.
 See `PKError` for specific `NSError` keys to use to enable rich error handling.
 */
@property (null_resettable, nonatomic, copy) NSArray<NSError *> *errors;

@end


/**
 Base class for updating the payment request after the shopper makes changes on the payment form.
 */
@interface OPPApplePayRequestUpdate : NSObject

/// @name Initialization

/**
 Initializes a payment request update with the given list of summary items.
 @param paymentSummaryItems The new payment summary items to update the payment request with.
*/
- (instancetype)initWithPaymentSummaryItems:(NSArray<PKPaymentSummaryItem *> *)paymentSummaryItems NS_DESIGNATED_INITIALIZER;

/// @name Properties

/**
 The status of the payment request update.
 Set `PKPaymentAuthorizationStatusSuccess` for a successful update, and `PKPaymentAuthorizationStatusFailure` if you were unable to process the required changes.
 `PKPaymentAuthorizationStatusSuccess` by default.
*/
@property (nonatomic) PKPaymentAuthorizationStatus status;

/**
 The new payment summary items to update the payment request with.
 */
@property (nonatomic, copy) NSArray<PKPaymentSummaryItem *> *paymentSummaryItems;

@end

/**
 Class for updating the payment request after the shipping contact information changed.
 */
@interface OPPApplePayRequestShippingContactUpdate : OPPApplePayRequestUpdate

/// @name Initialization

/**
 Initializes a payment request update with provided errors, payment summary items and shipping methods.
 @param errors List of errors in the shipping contact information (available for iOS 11 and higher). See `PKError` for specific `NSError` keys to use.
 @param paymentSummaryItems The new payment summary items to update the payment request with.
 @param shippingMethods The new shipping methods to update the payment request with.
 */
- (instancetype)initWithErrors:(nullable NSArray<NSError *> *)errors
           paymentSummaryItems:(NSArray<PKPaymentSummaryItem *> *)paymentSummaryItems
               shippingMethods:(NSArray<PKShippingMethod *> *)shippingMethods NS_DESIGNATED_INITIALIZER;

/// @name Properties

/**
 The new shipping methods to update the payment request with.
 */
@property (nonatomic, copy) NSArray<PKShippingMethod *> *shippingMethods;

/**
 List of errors in the shipping contact information (available for iOS 11 and higher).
 See `PKError` for specific `NSError` keys to use.
 */
@property (null_resettable, nonatomic, copy) NSArray<NSError *> *errors;

@end

/**
 Class for updating the payment request after the shipping method changed.
 */
@interface OPPApplePayRequestShippingMethodUpdate : OPPApplePayRequestUpdate

@end

NS_ASSUME_NONNULL_END
