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

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
/**
 A constant to be used instead of specific card brand. The brand will be detected automatically based on card number.
 */
extern NSString *const OPPPaymentBrandCard;

/**
 Class that extends UIButton in order to esily integrate separate payment methods in the app.
 
 By default button contains appropriate logo if a valid payment method is set. Button can be fully customized as common UIButton.
 
 To create and submit a transaction, use `-[OPPCheckoutProvider presentCheckoutWithPaymentBrand:loadingHandler:completionHandler:cancelHandler:]` in button action method.
 */
@interface OPPPaymentButton : UIButton

/// @name Initialization

/**
 Creates and returns payment button initialized with the payment brand.
 @param paymentBrand Payment brand for the transaction.
 */
+ (instancetype)paymentButtonWithPaymentBrand:(NSString *)paymentBrand;

/**
 Creates and returns payment button initialized with the payment method.
 @param paymentBrand Payment brand for the transaction.
 */
- (instancetype)initWithPaymentBrand:(NSString *)paymentBrand;

/// @name Properties

/**
 Payment brand for the transaction that is used to display an appropriate logo.
 Logo will be loaded automatically from the Server.
 To use your own image for a button, set it before initializing the payment brand.
 */
@property (nonatomic, copy) NSString *paymentBrand;

@end
NS_ASSUME_NONNULL_END
