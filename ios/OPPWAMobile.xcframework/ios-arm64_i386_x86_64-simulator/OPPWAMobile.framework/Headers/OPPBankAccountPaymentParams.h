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

/** Class to encapsulate all necessary transaction parameters for performing a bank transfer transaction. */

NS_ASSUME_NONNULL_BEGIN
@interface OPPBankAccountPaymentParams : OPPPaymentParams

/// @name Initialization

/// :nodoc:
- (instancetype)initWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand error:(NSError * _Nullable __autoreleasing *)error NS_UNAVAILABLE;

/**
 Creates an object representing a SEPA direct debit transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param holder The name of the bank account holder.
 @param IBAN The IBAN (International Bank Account Number) associated with the bank account.
 @param tokenizationEnabled If `YES`, the payment information will be stored for future use.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a SEPA direct debit transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)directDebitSEPAPaymentParamsWithCheckoutID:(NSString *)checkoutID holder:(NSString *)holder IBAN:(NSString *)IBAN tokenizationEnabled:(BOOL)tokenizationEnabled error:(NSError **)error;

/**
 Creates an object representing a SOFORT banking transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param country The country code of the bank account (ISO 3166-1).
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a SOFORT banking transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)sofortBankingPaymentParamsWithCheckoutID:(NSString *)checkoutID country:(NSString *)country error:(NSError **)error;

/**
 Creates an object representing an IDEAL transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param bankName The name of the bank which holds the account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing an IDEAL transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)idealPaymentParamsWithCheckoutID:(NSString *)checkoutID bankName:(NSString *)bankName error:(NSError **)error;

/**
 Creates an object representing a Giropay transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param BIC The BIC (Bank Identifier Code (SWIFT)) number of the bank account. Either the bankCode or the BIC are required.
 @param bankCode The code associated with the bank account. Either the bankCode or the BIC are required.
 @param IBAN The IBAN (International Bank Account Number) associated with the bank account.
 @param accountNumber The account number of the bank account.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a Giropay transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)giropayPaymentParamsWithCheckoutID:(NSString *)checkoutID BIC:(nullable NSString *)BIC bankCode:(nullable NSString *)bankCode IBAN:(nullable NSString *)IBAN accountNumber:(nullable NSString *)accountNumber error:(NSError **)error;

/**
 Creates an object representing a Paytrail transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a Paytrail transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)paytrailPaymentParamsWithCheckoutID:(NSString *)checkoutID error:(NSError **)error;


/// @name Properties

/** The name of the bank account holder. */
@property (nonatomic, copy, readonly, nullable) NSString *holder;

/** The IBAN (International Bank Account Number) associated with the bank account. */
@property (nonatomic, copy, readonly, nullable) NSString *IBAN;

/** The account number of the bank account. Either the account number or the IBAN are required. */
@property (nonatomic, copy, readonly, nullable) NSString *accountNumber;

/** The country code of the bank account (ISO 3166-1). */
@property (nonatomic, copy, readonly, nullable) NSString *country;

/** The name of the bank which holds the account. */
@property (nonatomic, copy, readonly, nullable) NSString *bankName;

/** The BIC (Bank Identifier Code (SWIFT)) number of the bank account. Either the bankCode or the BIC are required. */
@property (nonatomic, copy, readonly, nullable) NSString *BIC;

/** The code associated with the bank account. Either the bankCode or the BIC are required. */
@property (nonatomic, copy, readonly, nullable) NSString *bankCode;

/** Default is `NO`. If `YES`, the payment information will be stored for future use. */
@property (nonatomic, readonly, getter=isTokenizationEnabled) BOOL tokenizationEnabled;

/// @name Validation methods

/**
 Checks if the bank account holder name is filled with sufficient data to perform a transaction.
 
 @param holder The name of the bank account holder.
 @return `YES` if the holder name contains more than 4 characters, up to 128 characters.
 */
+ (BOOL)isHolderValid:(NSString *)holder;

/**
 Checks if the IBAN is valid.
 The first two 2 characters specify the country code as of ISO 3166-1 alpha-2. Only letters.
 The next 2 characters specify the check digits for a sanity check. Only digits.
 The remaining characters up to 27 characters specify the Basic Bank Account Number (“BBAN”). Both letters & digits allowed.
 
 @param IBAN International Bank Account Number.
 @return `YES` if the IBAN meets the criteria described above.
 */
+ (BOOL)isIBANValid:(NSString *)IBAN;

/**
 Checks if the account number is valid.
 
 @param accountNumber The account number of the bank account.
 @return `YES` if the account number is valid.
 */
+ (BOOL)isAccountNumberValid:(NSString *)accountNumber;

/**
 Checks if the country code matches ISO 3166-1 two-letter standard.
 
 @param country The country of the bank account.
 @return `YES` if the country code matches ISO 3166-1 two-letter standard.
 */
+ (BOOL)isCountryValid:(NSString *)country;

/**
 Checks if the name of the bank is valid.
 
 @param bankName The name of the bank which holds the account.
 @return `YES` if the name of the bank is valid.
 */
+ (BOOL)isBankNameValid:(NSString *)bankName;

/**
 Checks if the BIC is valid.
 
 @param BIC The BIC (Bank Identifier Code (SWIFT)) number of the bank account.
 @return `YES` if the BIC is valid.
 */
+ (BOOL)isBICValid:(NSString *)BIC;

/**
 Checks if the bank code is valid.
 
 @param bankCode The code associated with the bank account.
 @return `YES` if the bank code is valid.
 */
+ (BOOL)isBankCodeValid:(NSString *)bankCode;

@end
NS_ASSUME_NONNULL_END
