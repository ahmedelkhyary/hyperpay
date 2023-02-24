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
#import "OPPPaymentParams.h"

/**
 Class to represent a set of base parameters for common and tokenized cards.
*/

NS_ASSUME_NONNULL_BEGIN
@interface OPPBaseCardPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID
                      paymentBrand:(NSString *)paymentBrand
                             error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/** The CVV code found on the card. Property should be set, if CVV check is required for transaction processing. */
@property (nonatomic, copy, readonly, nullable) NSString *CVV;

/** The number of installments the payment should be split into. */
@property (nonatomic, copy, nullable) NSNumber *numberOfInstallments;

/** The params needed for 3-D Secure 2 authentication request. */
@property (nonatomic, copy, nullable) NSString *threeDS2AuthParams;

/**
 Checks if the card CVV is filled with sufficient data to perform a transaction.
 
 @param CVV The card security code or CVV.
 @return `YES` if 3,4-digit number is provided.
 */
+ (BOOL)isCvvValid:(NSString *)CVV;

@end

NS_ASSUME_NONNULL_END
