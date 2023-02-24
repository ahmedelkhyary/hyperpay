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
#import "OPPBaseCardPaymentParams.h"
#import "OPPBillingAddress.h"

/**
 Class to represent a set of card parameters needed for performing an e-commerce card transaction.

 It offers сonvenience methods for checking if the number is valid, i.e. if it passes the Luhn check and can be assigned to one of the major card companies.
 
 After getting an authorization for the transaction the parameters are masked in accordance to PCI PA DSS requirements.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPCardPaymentParams : OPPBaseCardPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing a card transaction.

 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand The payment brand of the card.
 @param holder The name of the card holder.
 @param number The card number of the transaction.
 @param expiryYear The expiration year. It is expected in the format `YYYY`.
 @param expiryMonth The expiration month of the card. It is expected in the format `MM`.
 @param CVV The CVV code associated with the card. Set to `nil` if CVV is not required.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a card transaction, and `nil` if parameters are invalid.
*/
+ (nullable instancetype)cardPaymentParamsWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand holder:(nullable NSString *)holder number:(NSString *)number expiryMonth:(nullable NSString *)expiryMonth expiryYear:(nullable NSString *)expiryYear CVV:(nullable NSString *)CVV error:(NSError * _Nullable *)error;

/**
 Creates an object representing a card transaction without specifying a brand.
 Use it only with BIP settings 'automatic brand detection' activated.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param holder The name of the card holder.
 @param number The card number of the transaction.
 @param expiryYear The expiration year. It is expected in the format `YYYY`.
 @param expiryMonth The expiration month of the card. It is expected in the format `MM`.
 @param CVV The CVV code associated with the card. Set to `nil` if CVV is not required.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a card transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)cardPaymentParamsWithCheckoutID:(NSString *)checkoutID holder:(nullable NSString *)holder number:(NSString *)number expiryMonth:(nullable NSString *)expiryMonth expiryYear:(nullable NSString *)expiryYear CVV:(nullable NSString *)CVV error:(NSError * _Nullable *)error;

/**
 Creates an object representing a card transaction.
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand The payment brand of the card.
 @param holder The name of the cardholder.
 @param number The card number of the transaction.
 @param expiryYear The expiration year. It is expected in the format `YYYY`.
 @param expiryMonth The expiration month of the card. It is expected in the format `MM`.
 @param CVV The CVV code associated with the card. Set to `nil` if CVV is not required.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a card transaction, and `nil` if parameters are invalid.
 */
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand holder:(nullable NSString *)holder number:(NSString *)number expiryMonth:(nullable NSString *)expiryMonth expiryYear:(nullable NSString *)expiryYear CVV:(nullable NSString *)CVV error:(NSError * _Nullable *)error NS_DESIGNATED_INITIALIZER;

/// @name Properties

/** Holder of the card account. The length must be greater than 3 characters and less then 128 character. */
@property (nonatomic, copy, readonly) NSString *holder;

/** The card number. It may contain spaces `" "` and dashes `"-"`. */
@property (nonatomic, copy, readonly) NSString *number;

/** The card expiry month in the format `MM`. */
@property (nonatomic, copy, readonly) NSString *expiryMonth;

/** The card expiry year in the format `YYYY`. */
@property (nonatomic, copy, readonly) NSString *expiryYear;

/** The customer's country code. */
@property (nonatomic, copy) NSString *countryCode;

/** The customer's mobile number. */
@property (nonatomic, copy) NSString *mobilePhone;

/** Default is `NO`. If `YES`, the payment information will be stored for future use. */
@property (nonatomic, getter=isTokenizationEnabled) BOOL tokenizationEnabled;

/** The customer's billing address. */
@property (nonatomic, strong, nullable) OPPBillingAddress *address;

/// @name Parameter Checks

/**
 Checks if the holder name is filled with sufficient data to perform a transaction.
 
 @param holder Holder of the card account.
 @return `YES` if the holder name length greater than 3 characters and less than 128 character.
 */
+ (BOOL)isHolderValid:(NSString *)holder;

/**
 Checks if the card number is filled with sufficient data to perform a transaction.
 
 @param number Card number.
 @param luhnCheck Set to `YES` if number should pass Luhn test http://en.wikipedia.org/wiki/Luhn_algorithm.
 @return `YES` if the number consists of 10-19 digits and passes luhn test, `NO` if it doesn't.
 */
+ (BOOL)isNumberValid:(NSString *)number luhnCheck:(BOOL)luhnCheck;

/**
 Checks if the card expiry month is filled with sufficient data to perform a transaction.
 
 @param expiryMonth The expiry month of the card.
 @return `YES` if the card expiry month is in the format `MM`.
 */
+ (BOOL)isExpiryMonthValid:(NSString *)expiryMonth;

/**
 Checks if the card expiry year is filled with sufficient data to perform a transaction.
 
 @param expiryYear The expiry year of the card.
 @return `YES` if the card expiry year is in the format `YYYY`.
 */
+ (BOOL)isExpiryYearValid:(NSString *)expiryYear;

/**
 Checks if the country code is filled with sufficient data to perform a transaction.
 
 @param countryCode The country code.
 @return `YES` if the country code contains digits only.
 */
+ (BOOL)isCountryCodeValid:(NSString *)countryCode;

/**
 Checks if the mobile phone is filled with sufficient data to perform a transaction.
 
 @param mobilePhone The mobile phone number.
 @return `YES` if the mobile phone number contains digits only.
 */
+ (BOOL)isMobilePhoneValid:(NSString *)mobilePhone;

/**
 Checks if the month and year have been set and whether or not card is expired.
 
 @param month The expiry month of the card.
 @param year The expiry year of the card.
 @return `YES` if the month or the year is expired. `NO` if the card is not expired yet.
 */
+ (BOOL)isExpiredWithExpiryMonth:(NSString *)month andYear:(NSString *)year;


@end
NS_ASSUME_NONNULL_END
