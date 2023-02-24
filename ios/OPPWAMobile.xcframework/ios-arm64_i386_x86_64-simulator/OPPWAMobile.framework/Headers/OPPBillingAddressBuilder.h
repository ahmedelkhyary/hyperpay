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
 Builder class for costructing billing address object.
 */
@interface OPPBillingAddressBuilder : NSObject

/**
 Set billing address country.
 @param country The country of the billing address.
 @return self.
 */
- (instancetype)withCountry:(nonnull NSString *)country;

/**
 Set billing address state.
 @param state the county, state or region of the billing address.
 @return self.
 */
- (instancetype)withState:(nonnull NSString *)state;

/**
 Set billing address city.
 @param city The town, district or city of the billing address.
 @return self.
 */
- (instancetype)withCity:(nonnull NSString *)city;

/**
 Set billing address post code.
 @param postCode The postal code or zip code of the billing address.
 @return self.
 */
- (instancetype)withPostCode:(nonnull NSString *)postCode;

/**
 Set billing address street1.
 @param street1Required The door number, floor, building number, building name, and/or street name of the billing address.
 @return self.
*/
- (instancetype)withStreet1:(nonnull NSString *)street1;

/**
 Set billing address street2.
 @param street2Required The adjoining road or locality (if required) of the billing address.
 @return self.
 */
- (instancetype)withStreet2:(nonnull NSString *)street2;

/**
 Update billing address country required flag.
 Default is `YES`.
 */
- (nonnull instancetype)withCountryRequired:(BOOL)countryRequired;

/**
 Update billing address state required flag.
 Default is `YES`.
 */
- (instancetype)withStateRequired:(BOOL)stateRequired;

/**
 Update billing address city required flag.
 Default is `YES`.
 */
- (instancetype)withCityRequired:(BOOL)cityRequired;

/**
 Update billing address post code required flag.
 Default is `YES`.
 */
- (instancetype)withPostCodeRequired:(BOOL)postCodeRequired;

/**
 Update billing address street1 required flag.
 Default is `YES`.
 */
- (instancetype)withStreet1Required:(BOOL)street1Required;

/**
 Update billing address street2 required flag.
 Default is `YES`.
 */
- (instancetype)withStreet2Required:(BOOL)street2Required;

/**
 Creates a new billing address.
 @param error The error that occured while building billing address object.
 @return the billing address.
 */
- (OPPBillingAddress *)build;

@end
NS_ASSUME_NONNULL_END
