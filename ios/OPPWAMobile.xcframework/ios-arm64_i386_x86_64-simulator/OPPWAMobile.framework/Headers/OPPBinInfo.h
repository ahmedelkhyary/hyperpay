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

NS_ASSUME_NONNULL_BEGIN

/**
 Class to encapsulate a BIN (Bank Identification Number) details of a payment card.
 */
@interface OPPBinInfo : NSObject

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Creates OPPBinInfo info object with the provided list of brands, BIN type and type of payment method/card.
 @param brands Payments brands which are related to BIN.
 @param binType Type of the BIN detected by the BIN Service. PERSONAL or COMMERCIAL.
 @param type Payment method/card type detected by the BIN Service.  DEBIT,  CREDIT or CHARGE CARD.
 @return an `OPPBinInfo` object.
 */
- (nullable instancetype)initWithBrands:(NSArray<NSString *> *)brands
                                binType:(nullable NSString *)binType
                                   type:(nullable NSString *)type NS_DESIGNATED_INITIALIZER;

/**
 Creates OPPBinInfo info object with the provided list of brands, BIN type and type of payment method/card.
 @param brands Payments brands which are related to BIN.
 @param binType Type of the BIN detected by the BIN Service. PERSONAL or COMMERCIAL.
 @param type Payment method/card type detected by the BIN Service.  DEBIT,  CREDIT or CHARGE CARD.
 @return an `OPPBinInfo` object.
 */
+ (nullable instancetype)binInfoWithBrands:(NSArray<NSString *> *)brands
                                   binType:(nullable NSString *)binType
                                      type:(nullable NSString *)type;

/// @name Properties

/// Payments brands which are related to BIN.
@property (nonatomic, copy, readonly) NSArray<NSString *> *brands;
 
/// Type of the BIN detected by the BIN Service.
/// Possible values: PERSONAL or COMMERCIAL.
@property (nonatomic, copy, readonly, nullable) NSString *binType;

/// Payment method/card type detected by the BIN Service.
/// Possible values: DEBIT,  CREDIT, CHARGE CARD.
@property (nonatomic, copy, readonly, nullable) NSString *type;

@end

NS_ASSUME_NONNULL_END
