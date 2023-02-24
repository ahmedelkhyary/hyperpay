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
 Class to encapsulate all necessary transaction parameters for performing an Ikano private label transaction (as virtual account).
 */

NS_ASSUME_NONNULL_BEGIN

@interface OPPIkanoPrivateLabelVAPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID
                      paymentBrand:(NSString *)paymentBrand
                             error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
Creates an object representing an Ikano private label transaction (as virtual account).

@param checkoutID The checkout ID of the transaction.
@param accountNumber The account number.
@param expiryMonth The expiration month of the account. It is expected in the format `MM`.
@param expiryYear The expiration year of the account. It is expected in the format `YYYY`.
@param accountVerification The verification code of the account.
@param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
@return Returns an object representing an Ikano private label transaction (as virtual account).
*/
+ (nullable instancetype)ikanoPrivateLabelVAPaymentParamsWithCheckoutID:(NSString *)checkoutID
                                                          accountNumber:(NSString *)accountNumber
                                                            expiryMonth:(NSString *)expiryMonth
                                                             expiryYear:(NSString *)expiryYear
                                                    accountVerification:(nullable NSString *)accountVerification
                                                                  error:(NSError **)error;

/**
Creates an object representing an Ikano private label transaction (as virtual account).

@param checkoutID The checkout ID of the transaction.
@param accountNumber The account number.
@param expiryMonth The expiration month of the account. It is expected in the format `MM`.
@param expiryYear The expiration year of the account. It is expected in the format `YYYY`.
@param accountVerification The verification code of the account.
@param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
@return Returns an object representing an Ikano private label transaction (as virtual account).
*/
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID
                              accountNumber:(NSString *)accountNumber
                                expiryMonth:(NSString *)expiryMonth
                                 expiryYear:(NSString *)expiryYear
                        accountVerification:(nullable NSString *)accountVerification
                                      error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/// @name Properties

/** The account number. */
@property (nonatomic, copy, readonly) NSString *accountNumber;

/** The expiration month of the account in the format `MM`. */
@property (nonatomic, copy, readonly) NSString *expiryMonth;

/** The expiration year of the account in the format `YYYY`. */
@property (nonatomic, copy, readonly) NSString *expiryYear;

/** The verification code of the account. */
@property (nonatomic, copy, readonly) NSString *accountVerification;

/// @name Parameter Checks

/**
 Checks if account number is valid (card number validation used).
 
 @param accountNumber The account number.
 @return `YES` if account number is valid, `NO` if it doesn't.
 */
+ (BOOL)isAccountNumberValid:(NSString *)accountNumber;

/**
 Checks if expiration month is valid, `MM` format expected.
 
 @param expiryMonth The expiration month of the account.
 @return `YES` if expiration month is valid, `NO` if it doesn't.
 */
+ (BOOL)isExpiryMonthValid:(NSString *)expiryMonth;

/**
 Checks if expiration year is valid, `YYYY` format expected.
 
 @param expiryYear The expiration year of the account.
 @return `YES` if expiration year is valid, `NO` if it doesn't.
 */
+ (BOOL)isExpiryYearValid:(NSString *)expiryYear;

/**
 Checks if account is expired, expiration month and year should represent some date in the future.
 
 @param expiryMonth The expiration month of the account.
 @param expiryYear The expiration year of the account.
 @return `YES` if the account is expired. `NO` if the account is not expired yet.
 */
+ (BOOL)isAccountExpiredWithExpiryMonth:(NSString *)expiryMonth andYear:(NSString *)expiryYear;

/**
 Checks if verification code in valid, up to 5 digits expected.
 
 @param accountVerification The verification code of the account.
 @return `YES` if the verification code is valid, `NO` if it doesn't.
 */
+ (BOOL)isAccountVerificationValid:(NSString *)accountVerification;

@end

NS_ASSUME_NONNULL_END
