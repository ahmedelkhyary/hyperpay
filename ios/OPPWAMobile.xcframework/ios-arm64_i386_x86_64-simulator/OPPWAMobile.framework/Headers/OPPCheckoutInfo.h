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
@class OPPToken;
@class OPPPaymentBrandsConfig;

/// An enumeration of possible 3-D Secure 2 flows.
typedef NS_ENUM(NSInteger, OPPThreeDS2Flow) {
    /// 3-D Secure 2 native application flow.
    OPPThreeDS2FlowApp,
    /// 3-D Secure 2 native browser flow.
    OPPThreeDS2FlowWeb,
    /// Fallback to  3-D Secure 1 flow.
    OPPThreeDS2FlowDisabled
};

/** Class to encapsulate the parameters related to the checkout. */

NS_ASSUME_NONNULL_BEGIN
@interface OPPCheckoutInfo : NSObject

/// @name Properties

/** The amount of the transaction in the specified currency. */
@property (nonatomic) NSDecimalNumber *amount;

/** ISO 4217 currency code. */
@property (nonatomic, copy) NSString *currencyCode;

/** Tokens related to the checkout. */
@property (nonatomic, copy, nullable) NSArray<OPPToken *> *tokens;

/** Brand configuration parameters from the Server. */
@property (nonatomic, nullable) OPPPaymentBrandsConfig *paymentBrandsConfig;

/** The endpoint where the transaction will be sent to. */
@property (nonatomic, copy) NSString *endpoint;

/** Relative path to get status of transaction. */
@property (nonatomic, copy) NSString *resourcePath;

/** The merchant IDs related to Klarna Invoice and Klarna Installments. */
@property (nonatomic, copy, nullable) NSArray<NSString *> *klarnaMerchantIDs;

/** Shows if ReD Shield Device Id collecting is enabled or disabled. */
@property (nonatomic) BOOL collectRedShieldDeviceId;

/** Payment brands for which 3-D Secure 2 is enabled. */
@property (nonatomic, copy) NSArray<NSString *> *threeDS2Brands;

/** 3-D Secure 2 integration flow. */
@property (nonatomic, assign) OPPThreeDS2Flow threeDS2Flow;

/** A flag that specifies if browser parameters should be collected for 3-D Secure 2. */
@property (nonatomic, getter=isBrowserParamsRequired) BOOL browserParamsRequired;

/// @name Initialization

/**
 Creates checkout info object from the JSON that can be received from the Server by checkout ID.
 @param JSON A dictionary with parameters received from the Server.
 @param error An error if JSON is invalid.
 @return Returns an `OPPCheckoutInfo` object, or `nil` if JSON is invalid.
 */
+ (nullable instancetype)checkoutInfoFromJSON:(NSDictionary *)JSON error:(NSError * _Nullable *)error;

@end
NS_ASSUME_NONNULL_END
