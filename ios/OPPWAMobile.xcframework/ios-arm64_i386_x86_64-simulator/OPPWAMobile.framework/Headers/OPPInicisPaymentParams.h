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
 Class to encapsulate all necessary transaction parameters for performing KG Inicis transaction.
 */
NS_ASSUME_NONNULL_BEGIN
@interface OPPInicisPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID
                      paymentBrand:(NSString *)paymentBrand
                             error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing a KG Inicis transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing KG Inicis transaction.
*/
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID
                                      error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/**
 Creates an object representing a KG Inicis transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing KG Inicis transaction.
*/
+ (nullable instancetype)inicisPaymentParamsWithCheckoutID:(NSString *)checkoutID
                                                     error:(NSError **)error;

@end
NS_ASSUME_NONNULL_END
