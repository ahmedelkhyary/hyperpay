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

#import "OPPPaymentParams.h"

/**
 Class to encapsulate all necessary transaction parameters for performing an MB WAY transaction.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPMBWayPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID
                      paymentBrand:(NSString *)paymentBrand
                             error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing an MB WAY transaction.

 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param email Email of the account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing an MB WAY transaction.
 */
+ (nullable instancetype)mbWayPaymentParamsWithCheckoutID:(NSString *)checkoutID
                                                    email:(NSString *)email
                                                    error:(NSError **)error;

/**
 Creates an object representing an MB WAY transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param countryCode Country code of the mobile phone number.
 @param phoneNumber Mobile phone number of the account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing an MB WAY transaction.
 */
+ (nullable instancetype)mbWayPaymentParamsWithCheckoutID:(NSString *)checkoutID
                                              countryCode:(NSString *)countryCode
                                              phoneNumber:(NSString *)phoneNumber
                                                    error:(NSError **)error;

/// @name Properties

/** Email of the account. */
@property (nonatomic, copy, readonly) NSString *email;

/** Country code of the mobile phone number. */
@property (nonatomic, copy, readonly) NSString *countryCode;

/** Mobile phone number of the account. */
@property (nonatomic, copy, readonly) NSString *phoneNumber;

@end
NS_ASSUME_NONNULL_END
