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
 Class to encapsulate all necessary transaction parameters for performing an Ikano transaction.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPIkanoOiPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID
                      paymentBrand:(NSString *)paymentBrand
                             error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing an Ikano transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand IKANOOI_SE, IKANOOI_NO or IKANOOI_FI is expected.
 @param nationalIdentifier National identifier of the account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing an Ikano transaction.
 */
+ (nullable instancetype)ikanoOiPaymentParamsWithCheckoutID:(NSString *)checkoutID
                                               paymentBrand:(NSString *)paymentBrand
                                         nationalIdentifier:(NSString *)nationalIdentifier
                                                      error:(NSError **)error;

/**
 Creates an object representing an Ikano transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand IKANOOI_SE, IKANOOI_NO or IKANOOI_FI is expected.
 @param nationalIdentifier National identifier of the account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing an Ikano transaction.
 */
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID
                               paymentBrand:(NSString *)paymentBrand
                         nationalIdentifier:(NSString *)nationalIdentifier
                                      error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/// @name Properties

/** National identifier of the account. */
@property (nonatomic, copy, readonly) NSString *nationalIdentifier;

/// @name Parameter Checks

/**
 Checks if the national identifier is valid to perform a transaction.
 
 @param nationalIdentifier National identifier of the account.
 @param paymentBrand IKANOOI_SE, IKANOOI_NO or IKANOOI_FI is expected.
 @return `YES` if the national identifier value is valid.
 */
+ (BOOL)isNationalIdentifierValid:(NSString *)nationalIdentifier
                  forPaymentBrand:(NSString *)paymentBrand;

@end
NS_ASSUME_NONNULL_END
