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
 Class to encapsulate shopper’s bank account details that have been tokenized.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPBankAccount : NSObject

/// @name Properties

/** The name of the bank account holder. */
@property (nonatomic, copy) NSString *holder;

/** The IBAN (International Bank Account Number) associated with the bank account. */
@property (nonatomic, copy) NSString *IBAN;

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates an `OPPBankAccount` object from the JSON.
 @param JSON A dictionary with parameters received from the Server.
 @return Returns an `OPPBankAccount` object, or `nil` if JSON contains invalid values.
 */
+ (nullable instancetype)bankAccountFromJSON:(NSDictionary *)JSON;

/**
 Creates an `OPPBankAccount` object with the provided values.
 @param holder The name of the bank account holder.
 @param IBAN The IBAN (International Bank Account Number) associated with the bank account.
 @return Returns an `OPPBankAccount` object, or `nil` if parameters are empty.
 */
+ (nullable instancetype)bankAccountWithHolder:(NSString *)holder IBAN:(NSString *)IBAN;

/**
 Creates an `OPPBankAccount` object with the provided values.
 @param holder The name of the bank account holder.
 @param IBAN The IBAN (International Bank Account Number) associated with the bank account.
 @return Returns an `OPPBankAccount` object, or `nil` if parameters are empty.
 */
- (nullable instancetype)initWithHolder:(NSString *)holder IBAN:(NSString *)IBAN NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
