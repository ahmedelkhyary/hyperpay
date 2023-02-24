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

/** Class to encapsulate the payment brand configuration parameters from the Server. */

NS_ASSUME_NONNULL_BEGIN
@interface OPPPaymentBrandsConfig : NSObject

/// @name Properties

/** A flag that specifies whether payment brands from the Server are enabled or not. */
@property (nonatomic, readonly, getter=isEnabled) BOOL enabled;

/** Payment brand list from the Server. */
@property (nonatomic, copy, readonly) NSArray<NSString *> *paymentBrands;

/** A flag that specifies whether override checkout payment brands with brands from the Server or not. */
@property (nonatomic, readonly) BOOL shouldOverride;

/// @name Initialization

/**
 Creates `OPPPaymentBrandsConfig` object from the JSON that can be received from the Server by checkout ID.
 @param JSON A dictionary with parameters received from the Server.
 @return Returns an `OPPPaymentBrandsConfig` object, or `nil` if JSON contains invalid values.
 */
+ (nullable instancetype)paymentBrandsConfigFromJSON:(NSDictionary *)JSON;

/**
 Creates an `OPPPaymentBrandsConfig` object with the provided values.
 @param paymentBrands List of payment brands from the Server.
 @param enabled A flag that specifies whether payment brands from the Server are enabled or not.
 @param shouldOverride A flag that specifies whether override checkout payment brands with brands from the Server or not.
 */
+ (instancetype)paymentBrandsConfigWithPaymentBrands:(NSArray<NSString *> *)paymentBrands enabled:(BOOL)enabled shouldOverride:(BOOL)shouldOverride;

/**
 Creates an `OPPPaymentBrandsConfig` object with the provided values.
 @param paymentBrands List of payment brands from the Server.
 @param enabled A flag that specifies whether payment brands from the Server are enabled or not.
 @param shouldOverride A flag that specifies whether override checkout payment brands with brands from the Server or not.
 */
- (instancetype)initWithPaymentBrands:(NSArray<NSString *> *)paymentBrands enabled:(BOOL)enabled shouldOverride:(BOOL)shouldOverride;

@end
NS_ASSUME_NONNULL_END
