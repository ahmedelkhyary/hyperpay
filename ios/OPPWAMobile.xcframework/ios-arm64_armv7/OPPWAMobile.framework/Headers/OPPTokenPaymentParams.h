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

#import "OPPBaseCardPaymentParams.h"

/**
 Class to encapsulate all necessary transaction parameters for performing a token transaction.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPTokenPaymentParams : OPPBaseCardPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing a token transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand Payment brand of the tokenized transaction.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a token transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)tokenPaymentParamsWithCheckoutID:(NSString *)checkoutID tokenID:(NSString *)tokenID paymentBrand:(NSString *)paymentBrand error:(NSError **)error;

/**
 Creates an object representing a token transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param cardPaymentBrand The payment brand of the tokenized card.
 @param CVV The CVV code found on the card.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a token transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)tokenPaymentParamsWithCheckoutID:(NSString *)checkoutID tokenID:(NSString *)tokenID cardPaymentBrand:(NSString *)cardPaymentBrand CVV:(nullable NSString *)CVV error:(NSError **)error;

/**
 Creates an object representing a token transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand Payment method brand.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a token transaction, and `nil` if parameters are invalid.
 */
 - (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID tokenID:(NSString *)tokenID paymentBrand:(NSString *)paymentBrand error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/**
 Creates an object representing a token transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param cardPaymentBrand The payment brand of the tokenized card.
 @param CVV The CVV code found on the card.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a token transaction, and `nil` if parameters are invalid.
 */
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID tokenID:(NSString *)tokenID cardPaymentBrand:(NSString *)cardPaymentBrand CVV:(nullable NSString *)CVV error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/// @name Properties

/**
 The identifier of the token that can be used to reference the token later.
 */
@property (nonatomic, copy, readonly) NSString *tokenID;

/// @name Validation methods
/**
 Checks if the token identifier is valid to perform a transaction.
 
 @param tokenID The identifier of the token that can be used to reference the token later.
 @return `YES` if token identifier is alpha-numeric string of length 32.
 */
+ (BOOL)isTokenIDValid:(NSString *)tokenID;

@end
NS_ASSUME_NONNULL_END
