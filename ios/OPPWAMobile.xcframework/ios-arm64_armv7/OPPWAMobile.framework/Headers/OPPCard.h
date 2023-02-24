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

/**
 Class to encapsulate shopper’s card details that have been tokenized.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPCard : NSObject

/// @name Properties

/** Name of card holder. */
@property (nonatomic, copy) NSString *holder;

/** The last 4 digits of the card number. */
@property (nonatomic, copy) NSString *last4Digits;

/** The card’s expiration month. */
@property (nonatomic, copy) NSString *expiryMonth;

/** The card’s expiration year. */
@property (nonatomic, copy) NSString *expiryYear;

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates an `OPPCard` object from JSON.
 @param JSON A dictionary with parameters received from the Server.
 @return Returns an `OPPCard` object, or `nil` if JSON contains invalid values.
 */
+ (nullable instancetype)cardFromJSON:(NSDictionary *)JSON;

/**
 Creates an `OPPCard` object with the provided values.
 @param holder  Name of card holder.
 @param last4Digits The last 4 digits of the card number.
 @param expiryMonth The card’s expiration month.
 @param expiryYear The card’s expiration year.
 @return Returns an `OPPCard` object, or `nil` if parameters are empty.
 */
+ (nullable instancetype)cardWithHolder:(nullable NSString *)holder last4Digits:(NSString *)last4Digits expiryMonth:(NSString *)expiryMonth expiryYear:(NSString *)expiryYear;

/**
 Creates an `OPPCard` object with the provided values.
 @param holder Name of card holder.
 @param last4Digits The last 4 digits of the card number.
 @param expiryMonth The card’s expiration month.
 @param expiryYear The card’s expiration year.
 @return Returns an `OPPCard` object, or `nil` if parameters are empty.
 */
- (nullable instancetype)initWithHolder:(nullable NSString *)holder last4Digits:(NSString *)last4Digits expiryMonth:(NSString *)expiryMonth expiryYear:(NSString *)expiryYear NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
