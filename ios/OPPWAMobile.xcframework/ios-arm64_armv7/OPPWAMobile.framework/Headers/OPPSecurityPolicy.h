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

/// An enumeration for the possible modes of security policy.
typedef NS_ENUM(NSInteger, OPPSecurityPolicyMode) {
    /// Device authentication is required to complete payment. Payment method won't be displayed in the list if neither Touch ID/FACE ID nor passcode are set.
    OPPSecurityPolicyModeDeviceAuthRequired,
    /// Require device authentication only if Touch ID, Face ID or passcode are set.
    OPPSecurityPolicyModeDeviceAuthRequiredIfAvailable,
    /// Shopper don't have to provide Touch ID, Face ID or passcode to complete payment.
    OPPSecurityPolicyModeDeviceAuthNotRequired
};

/**
 Class which is used to apply security policy mode for the set of payment methods.
 */
NS_ASSUME_NONNULL_BEGIN
@interface OPPSecurityPolicy : NSObject

/// @name Initialization

/**
 Creates security policy for the list of payment methods with specified mode.
 @param paymentBrands List of payment brands. Note that Apple Pay will be ignored, because device authentication is mandatory for this payment method.
 @param mode Mode of security policy which will be applied to the `paymentBrands`.
 */
+ (instancetype)securityPolicyWithPaymentBrands:(NSArray<NSString *> *)paymentBrands mode:(OPPSecurityPolicyMode)mode;

/**
 Creates security policy for tokens with specified mode.
 @param mode Mode of security policy which will be applied for all tokens.
 */
+ (instancetype)securityPolicyForTokensWithMode:(OPPSecurityPolicyMode)mode;

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;


/// @name Properties

/**
 The mode of security policy.
 */
@property (nonatomic, readonly) OPPSecurityPolicyMode mode;

/**
 The list of payment brands.
 */
@property (nonatomic, copy, readonly, nullable) NSArray<NSString *> *paymentBrands;

/**
 The flag that defines whether mode is applied to `paymentBrands` or to all tokens.
 */
@property (nonatomic, readonly, getter=isTokenPolicy) BOOL tokenPolicy;

@end
NS_ASSUME_NONNULL_END
