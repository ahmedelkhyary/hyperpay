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
#import "OPPCard.h"
#import "OPPBankAccount.h"
#import "OPPVirtualAccount.h"
#import "OPPPaymentParams.h"

/**
 Class to encapsulate shopper’s payment details that have been tokenized.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPToken : NSObject

/// @name Properties

/** The identifier of the token that can be used to reference the token later. */
@property (nonatomic, copy, readonly) NSString *tokenID;

/** The payment brand of the transaction. */
@property (nonatomic, copy, readonly) NSString *paymentBrand;

/** Shopper’s card details. */
@property (nonatomic, readonly, nullable) OPPCard *card;

/** Shopper’s bank account details. */
@property (nonatomic, readonly, nullable) OPPBankAccount *bankAccount;

/** Shopper’s virtual account details. */
@property (nonatomic, readonly, nullable) OPPVirtualAccount *virtualAccount;

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates an `OPPToken` object from JSON.
 @param JSON A dictionary with parameters received from the Server.
 @return Returns an `OPPToken` object, or `nil` if JSON contains invalid values.
 */
+ (nullable instancetype)tokenFromJSON:(NSDictionary *)JSON;

/**
 Creates an `OPPToken` object with provided card parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param card Shopper’s card details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
+ (nullable instancetype)tokenWithTokenID:(NSString *)tokenID
                             paymentBrand:(NSString *)paymentBrand
                                     card:(OPPCard *)card;

/**
 Creates an `OPPToken` object with provided bank account parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param bankAccount Shopper’s bank account details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
+ (nullable instancetype)tokenWithTokenID:(NSString *)tokenID
                             paymentBrand:(NSString *)paymentBrand
                              bankAccount:(OPPBankAccount *)bankAccount;

/**
 Creates an `OPPToken` object with provided virtual account parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param virtualAccount Shopper’s virtual account details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
+ (nullable instancetype)tokenWithTokenID:(NSString *)tokenID
                             paymentBrand:(NSString *)paymentBrand
                           virtualAccount:(OPPVirtualAccount *)virtualAccount;

/**
 Creates an `OPPToken` object with provided card parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param card Shopper’s card details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
- (nullable instancetype)initWithTokenID:(NSString *)tokenID
                            paymentBrand:(NSString *)paymentBrand
                                    card:(OPPCard *)card;

/**
 Creates an `OPPToken` object with provided bank account parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param bankAccount Shopper’s bank account details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
- (nullable instancetype)initWithTokenID:(NSString *)tokenID
                            paymentBrand:(NSString *)paymentBrand
                             bankAccount:(OPPBankAccount *)bankAccount;

/**
 Creates an `OPPToken` object with provided virtual account parameters.
 @param tokenID The identifier of the token that can be used to reference the token later.
 @param paymentBrand The payment brand.
 @param virtualAccount Shopper’s virtual account details.
 @return Returns an `OPPToken` object, or `nil` if parameters are empty.
 */
- (nullable instancetype)initWithTokenID:(NSString *)tokenID
                            paymentBrand:(NSString *)paymentBrand
                          virtualAccount:(OPPVirtualAccount *)virtualAccount;

@end
NS_ASSUME_NONNULL_END
