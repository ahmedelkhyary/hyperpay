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
 Class to represent a set of parameters needed for performing an e-commerce transaction.
 */

NS_ASSUME_NONNULL_BEGIN
@interface OPPPaymentParams : NSObject

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates an object representing a payment transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand The payment brand of the transaction.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a payment transaction, and `nil` if parameters are invalid.
 */
+ (nullable instancetype)paymentParamsWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand error:(NSError **)error;

/**
 Creates an object representing a payment transaction.
 
 @param checkoutID The checkout ID of the transaction. Must be not `nil` or empty.
 @param paymentBrand The payment brand of the transaction.
 @param error The error that occurred while validating payment parameters. See code attribute (`OPPErrorCode`) and `NSLocalizedDescription` to identify the reason of failure.
 @return Returns an object representing a payment transaction, and `nil` if parameters are invalid.
 */
- (nullable instancetype)initWithCheckoutID:(NSString *)checkoutID paymentBrand:(NSString *)paymentBrand error:(NSError **)error NS_DESIGNATED_INITIALIZER;

/// @name Properties

/** A property that can be set with a value from initial checkout request (mandatory). This value is required in the next steps. */
@property (nonatomic, copy, readonly) NSString *checkoutID;

/**
 The payment brand of the transaction.
 */
@property (nonatomic, copy, readonly) NSString *paymentBrand;

/**
 This URL will receive the result of an asynchronous payment. Must be sent URL encoded.
 */
@property (nonatomic, copy, nullable) NSString *shopperResultURL;

/**
 Dictionary of custom parameters that will be sent to the server.
 */
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *customParams;


/// @name Custom parameters methods 

/**
Method to add parameter that will be sent to the server.
@param name Parameter name, expected string that matches regex [0-9a-zA-Z._\\[\\]]{3,64}.
@param value Any string no longer than 2048 characters.
@return Returns `YES` if name and value are valid and parameter is successfully saved, otherwise `NO`.
*/
- (BOOL)addParamWithName:(NSString *)name value:(NSString *)value;

/**
 Method to remove record from the dictionary of parameters.
 @param name Parameter name.
 */
- (void)removeParamWithName:(NSString *)name;

/// @name Helper methods

/**
 Helper method to mask sensitive payment details such as card number, CVV and etc.
 */
- (void)mask;

@end
NS_ASSUME_NONNULL_END
