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

/// An enumeration for the various types of UI for displaying challenge screens.
/// @note An enumeration is represented by bitmask values that may be combined together. For example, it's valid to specify several options in an option set: `[.text, .html]`.
typedef NS_OPTIONS(NSUInteger, OPPThreeDSChallengeUiType) {
    /// Format for a one-time passcode (OTP) or text during a non-payment authentication transaction.
    OPPThreeDSChallengeUiTypeText = 1,
    /// Format that allows multiple options to be presented to the cardholder to obtain single response.
    OPPThreeDSChallengeUiTypeSingleSelect = 2,
    /// Format that allows multiple options to be presented to the Cardholder to obtain multiple response on single screen.
    OPPThreeDSChallengeUiTypeMultiSelect = 4,
    /// Format that allows to complete authentication outside of the merchant app, e.g. in issuer’s mobile app.
    OPPThreeDSChallengeUiTypeOob = 8,
    /// Format that allows to present issuer-specific designed html in a web view.
    OPPThreeDSChallengeUiTypeHtml = 16
};
