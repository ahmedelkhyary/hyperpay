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

NS_ASSUME_NONNULL_BEGIN
/**
 Class to hold billing address of the customer.
 */
@interface OPPBillingAddress : NSObject

/// @name Properties

/** The country of the billing address. */
@property (nonatomic, copy, nullable, readonly) NSString *country;

/** The county, state or region of the billing address. */
@property (nonatomic, copy, nullable, readonly) NSString *state;

/** The city of the billing address. */
@property (nonatomic, copy, nullable, readonly) NSString *city;

/** The postal code or zip code of the billing address. */
@property (nonatomic, copy, nullable, readonly) NSString *postCode;

/**
 The door number, floor, building number, building name, and/or street name of the billing address.
 Mandatory for 3D Secure v2.
 */
@property (nonatomic, copy, nullable, readonly) NSString *street1;

/**
 The adjoining road or locality (if required) of the billing address.
 The combination of street1 and street2 can't contain numbers only, it should also include characters.
*/
@property (nonatomic, copy, nullable, readonly) NSString *street2;

/**
 A flag that specifies if country is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isCountryRequired) BOOL countryRequired;

/**
 A flag that specifies if state is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isStateRequired) BOOL stateRequired;

/**
 A flag that specifies if city is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isCityRequired) BOOL cityRequired;

/**
 A flag that specifies if post code is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isPostCodeRequired) BOOL postCodeRequired;

/**
 A flag that specifies if street1 is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isStreet1Required) BOOL street1Required;

/**
 A flag that specifies if street1 is required.
 Default is `YES`.
*/
@property (nonatomic, readonly, getter=isStreet2Required) BOOL street2Required;

/// @name Initialization

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

@end
NS_ASSUME_NONNULL_END
