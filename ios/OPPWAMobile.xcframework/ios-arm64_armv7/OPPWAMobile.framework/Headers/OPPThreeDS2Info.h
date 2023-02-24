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

/// Enumeration of possible statuses for 3-D Secure 2 authentication.
typedef NS_ENUM(NSInteger, OPPThreeDS2Status) {
    /// Authentication/verification successful.
    OPPThreeDS2StatusAuthenticated,
    
    /// Not authentication/not verified, but a proof of attempted authentication/verification is provided.
    OPPThreeDS2StatusAttemptProcessingPerformed,
    
    /// In-app challenge required; additional authentication is required using in-app challenge screens.
    OPPThreeDS2StatusChallengeRequired,
    
    /// External challenge required; decoupled authentication confirmed.
    OPPThreeDS2StatusDecoupledConfirmed,
    
    /// Not authenticated or account not verified, transaction denied.
    OPPThreeDS2StatusDenied,
    
    /// Issuer is rejecting authentication/verification and request that authorisation not attempted.
    OPPThreeDS2StatusRejected,
    
    /// Authentication/verification cannot be performed due to some technical or other problems.
    OPPThreeDS2StatusFailed,
    
    /// Informational only; 3DS Requestor challenge preference acknowledged.
    OPPThreeDS2StatusInformationalOnly,
    
    /// Authentication parameters are required.
    OPPThreeDS2StatusAuthParamsRequired,
    
    /// Status is not defined.
    OPPThreeDS2StatusUndefined
};

/**
 Class to represent 3-D Secure 2 parameters.
 */
@interface OPPThreeDS2Info : NSObject

/**
 Status of 3-D Secure 2 authentication.
 */
@property (nonatomic, readonly) OPPThreeDS2Status authStatus;

/**
 Authentication response as json string required for launching in-app challenge screens.
 */
@property (nonatomic, copy, readonly, nullable) NSString *authResponse;

/**
 Protocol version of 3-D Secure 2.
 */
@property (nonatomic, copy, readonly, nullable) NSString *protocolVersion;

/**
 The callback URL string to send the params needed for 3-D Secure 2 authentication request.
 */
@property (nonatomic, copy, readonly, nullable) NSString *callbackURL;

/**
 Text provided by the ACS/Issuer to Cardholder during a Frictionless or Decoupled transaction.
 */
@property (nonatomic, copy, readonly, nullable) NSString *cardHolderInfo;

/**
 Creates 3DS info object with the provided status and authentication response.
 @param authStatus Status of 3-D Secure authentication.
 @param authResponse Authentication response as JSON string.
 @return an `OPPThreeDS2Info` object.
 */
- (nullable instancetype)initWithAuthStatus:(OPPThreeDS2Status)authStatus
                               authResponse:(nullable NSString *)authResponse NS_DESIGNATED_INITIALIZER;

/**
 Creates 3DS info object with the provided status and authentication response.
 @param authStatus Status of 3-D Secure authentication.
 @param authResponse Authentication response as JSON string.
 @return an `OPPThreeDS2Info` object.
*/
+ (nullable instancetype)threeDS2InfoWithAuthStatus:(OPPThreeDS2Status)authStatus
                                       authResponse:(nullable NSString *)authResponse;

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

/**
 Returns `YES` if in-app challenge is required, otherwise `NO`.
 @return `YES` if in-app challenge is required, otherwise `NO`.
 */
- (BOOL)isChallengeRequired;

@end

NS_ASSUME_NONNULL_END
