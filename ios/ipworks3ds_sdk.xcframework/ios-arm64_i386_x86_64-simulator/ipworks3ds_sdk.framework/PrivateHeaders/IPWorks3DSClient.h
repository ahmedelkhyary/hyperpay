
/***********************************************************************
  /n software 3-D Secure V2 for macOS and iOS
  Copyright (c) 2022 /n software inc. - All rights reserved.
************************************************************************/

#import <Foundation/Foundation.h>




//CERTSTORETYPES
#define CST_USER                                           0
#define CST_MACHINE                                        1
#define CST_PFXFILE                                        2
#define CST_PFXBLOB                                        3
#define CST_JKSFILE                                        4
#define CST_JKSBLOB                                        5
#define CST_PEMKEY_FILE                                    6
#define CST_PEMKEY_BLOB                                    7
#define CST_PUBLIC_KEY_FILE                                8
#define CST_PUBLIC_KEY_BLOB                                9
#define CST_SSHPUBLIC_KEY_BLOB                             10
#define CST_P7BFILE                                        11
#define CST_P7BBLOB                                        12
#define CST_SSHPUBLIC_KEY_FILE                             13
#define CST_PPKFILE                                        14
#define CST_PPKBLOB                                        15
#define CST_XMLFILE                                        16
#define CST_XMLBLOB                                        17
#define CST_JWKFILE                                        18
#define CST_JWKBLOB                                        19
#define CST_SECURITY_KEY                                   20
#define CST_BCFKSFILE                                      21
#define CST_BCFKSBLOB                                      22
#define CST_AUTO                                           99

//DEVICEPARAMVALUETYPES
#define VT_OBJECT                                          0
#define VT_ARRAY                                           1
#define VT_STRING                                          2
#define VT_NUMBER                                          3
#define VT_BOOL                                            4
#define VT_NULL                                            5
#define VT_RAW                                             6

//AUTHSCHEMES
#define AUTH_BASIC                                         0
#define AUTH_DIGEST                                        1
#define AUTH_PROPRIETARY                                   2
#define AUTH_NONE                                          3
#define AUTH_NTLM                                          4
#define AUTH_NEGOTIATE                                     5

//PROXYSSLTYPES
#define PS_AUTOMATIC                                       0
#define PS_ALWAYS                                          1
#define PS_NEVER                                           2
#define PS_TUNNEL                                          3


#ifndef NS_SWIFT_NAME
#define NS_SWIFT_NAME(x)
#endif

@protocol EventRandomStr <NSObject>
@optional
- (void)byWordWrappingVisibleViewController:(NSData*)dataPacket NS_SWIFT_NAME(byWordWrappingVisibleViewController(_:));
- (void)imageNameTransStatus:(NSData*)dataPacket NS_SWIFT_NAME(imageNameTransStatus(_:));
- (void)impFrameworkStubHelperSection:(int)sdkTransactionIDOnError :(NSString*)description NS_SWIFT_NAME(impFrameworkStubHelperSection(_:_:));
- (void)getUITypeVtArray:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(getUITypeVtArray(_:_:_:));
- (void)overlayMainResourcePath:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(overlayMainResourcePath(_:_:_:_:_:));
- (void)hasPrefixRemainStr:(NSString*)message NS_SWIFT_NAME(hasPrefixRemainStr(_:));
@end

@interface CONTINUEBundle : NSObject {
  @public void* m_pObj;
  @public CFMutableArrayRef m_rNotifiers;
  __unsafe_unretained id <EventRandomStr> stubCodeLengthGetDeviceData;
  BOOL m_raiseNSException;
  BOOL m_delegateHasDataPacketIn;
  BOOL m_delegateHasDataPacketOut;
  BOOL m_delegateHasError;
  BOOL m_delegateHasLog;
  BOOL m_delegateHasSSLServerAuthentication;
  BOOL m_delegateHasSSLStatus;
}

+ (CONTINUEBundle*)insetTransactionStatus;

- (id)init;
- (void)dealloc;

- (NSString*)resendInformationLabelRemoveParam;
- (int)setHidesBackButtonHeaderText;
- (int)eventErrorCode;

@property (nonatomic,readwrite,assign,getter=delegate,setter=heightCloseView:) id <EventRandomStr> delegate;
- (id <EventRandomStr>)delegate;
- (void) heightCloseView:(id <EventRandomStr>)anObject;

  /* Events */

- (void)byWordWrappingVisibleViewController:(NSData*)dataPacket NS_SWIFT_NAME(byWordWrappingVisibleViewController(_:));
- (void)imageNameTransStatus:(NSData*)dataPacket NS_SWIFT_NAME(imageNameTransStatus(_:));
- (void)impFrameworkStubHelperSection:(int)sdkTransactionIDOnError :(NSString*)description NS_SWIFT_NAME(impFrameworkStubHelperSection(_:_:));
- (void)getUITypeVtArray:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(getUITypeVtArray(_:_:_:));
- (void)overlayMainResourcePath:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(overlayMainResourcePath(_:_:_:_:_:));
- (void)hasPrefixRemainStr:(NSString*)message NS_SWIFT_NAME(hasPrefixRemainStr(_:));

  /* Properties */

@property (nonatomic,readwrite,assign,getter=IsStaticMethodAsyncAfter,setter=currentCmdLowercased:) NSString* IsStaticMethodAsyncAfter NS_SWIFT_NAME(IsStaticMethodAsyncAfter);
- (NSString*)IsStaticMethodAsyncAfter;
- (void)currentCmdLowercased:(NSString*)newRuntimeLicense;

@property (nonatomic,readonly,assign,getter=GetMessageSymbolTableList) NSString* GetMessageSymbolTableList NS_SWIFT_NAME(GetMessageSymbolTableList);
- (NSString*)GetMessageSymbolTableList;

@property (nonatomic,readwrite,assign,getter=pageBaseFallthrough,setter=decryptedBytesVmaddr:) BOOL pageBaseFallthrough NS_SWIFT_NAME(pageBaseFallthrough);
- (BOOL)pageBaseFallthrough NS_SWIFT_NAME(pageBaseFallthrough());
- (void)decryptedBytesVmaddr:(BOOL)newRaiseNSException NS_SWIFT_NAME(decryptedBytesVmaddr(_:));

@property (nonatomic,readonly,assign,getter=GetSectionInMatchOCustomize) NSString* GetSectionInMatchOCustomize NS_SWIFT_NAME(GetSectionInMatchOCustomize);
- (NSString*)GetSectionInMatchOCustomize NS_SWIFT_NAME(GetSectionInMatchOCustomize());

@property (nonatomic,readonly,assign,getter=SetHeadingTextColorPresentedViewController) NSString* SetHeadingTextColorPresentedViewController NS_SWIFT_NAME(SetHeadingTextColorPresentedViewController);
- (NSString*)SetHeadingTextColorPresentedViewController NS_SWIFT_NAME(SetHeadingTextColorPresentedViewController());

@property (nonatomic,readwrite,assign,getter=VmsizeOrderedSame,setter=getAcsTransactionIDNSFoundationVersionNumber:) int VmsizeOrderedSame NS_SWIFT_NAME(VmsizeOrderedSame);
- (int)VmsizeOrderedSame NS_SWIFT_NAME(VmsizeOrderedSame());
- (void)getAcsTransactionIDNSFoundationVersionNumber :(int)newACSRootCertCount NS_SWIFT_NAME(getAcsTransactionIDNSFoundationVersionNumber(_:));

- (NSString*)TAMPEREDMachO:(int)aCSRootCertIndex NS_SWIFT_NAME(TAMPEREDMachO(_:));
- (void)fileprivatePosition:(int)aCSRootCertIndex :(NSString*)newACSRootCertEncoded NS_SWIFT_NAME(fileprivatePosition(_:_:));

- (NSData*)HandleAlarm:(int)aCSRootCertIndex NS_SWIFT_NAME(HandleAlarm(_:));
- (void)getHeadingTextColorLittleEndian:(int)aCSRootCertIndex :(NSData*)newACSRootCertEncoded NS_SWIFT_NAME(getHeadingTextColorLittleEndian(_:_:));

- (NSString*)WithAlphaComponentUsingFont:(int)aCSRootCertIndex NS_SWIFT_NAME(WithAlphaComponentUsingFont(_:));
- (void)contentModeAcsSignedContent:(int)aCSRootCertIndex :(NSString*)newACSRootCertStore NS_SWIFT_NAME(contentModeAcsSignedContent(_:_:));

- (NSData*)CheckDecryptedString:(int)aCSRootCertIndex NS_SWIFT_NAME(CheckDecryptedString(_:));
- (void)mySecuredUITextFieldTopAnchor:(int)aCSRootCertIndex :(NSData*)newACSRootCertStore NS_SWIFT_NAME(mySecuredUITextFieldTopAnchor(_:_:));

- (NSString*)DecryptedBytesComparable:(int)aCSRootCertIndex NS_SWIFT_NAME(DecryptedBytesComparable(_:));
- (void)finalSelectedViewController:(int)aCSRootCertIndex :(NSString*)newACSRootCertStorePassword NS_SWIFT_NAME(finalSelectedViewController(_:_:));

- (int)RemoveViewControllerSDKRuntimeException:(int)aCSRootCertIndex NS_SWIFT_NAME(RemoveViewControllerSDKRuntimeException(_:));
- (void)getppidTypeIsEmpty:(int)aCSRootCertIndex :(int)newACSRootCertStoreType NS_SWIFT_NAME(getppidTypeIsEmpty(_:_:));

- (NSString*)ChallengeSelectInfoValueGetHeadingTextAlignment:(int)aCSRootCertIndex NS_SWIFT_NAME(ChallengeSelectInfoValueGetHeadingTextAlignment(_:));
- (void)hexHashTransactionID:(int)aCSRootCertIndex :(NSString*)newACSRootCertSubject NS_SWIFT_NAME(hexHashTransactionID(_:_:));

@property (nonatomic,readonly,assign,getter=DeviceParamCategoryLetters) NSString* DeviceParamCategoryLetters NS_SWIFT_NAME(DeviceParamCategoryLetters);
- (NSString*)DeviceParamCategoryLetters NS_SWIFT_NAME(DeviceParamCategoryLetters());

@property (nonatomic,readonly,assign,getter=availableLocaleIdentifiersSyscall) NSString* availableLocaleIdentifiersSyscall NS_SWIFT_NAME(availableLocaleIdentifiersSyscall);
- (NSString*)availableLocaleIdentifiersSyscall NS_SWIFT_NAME(availableLocaleIdentifiersSyscall());

@property (nonatomic,readwrite,assign,getter=systemLogInfo,setter=languageCodeIsFishhooked:) NSString* systemLogInfo NS_SWIFT_NAME(systemLogInfo);
- (NSString*)systemLogInfo NS_SWIFT_NAME(systemLogInfo());
- (void)languageCodeIsFishhooked :(NSString*)newChallengeCancellationIndicator NS_SWIFT_NAME(languageCodeIsFishhooked(_:));

@property (nonatomic,readonly,assign,getter=cancelActionCydiaURLGroup) BOOL cancelActionCydiaURLGroup NS_SWIFT_NAME(cancelActionCydiaURLGroup);
- (BOOL)cancelActionCydiaURLGroup NS_SWIFT_NAME(cancelActionCydiaURLGroup());

@property (nonatomic,readwrite,assign,getter=getChallengeStatusReceiverBoundsWithPadding,setter=stringObfuscationTestLoadImage:) NSString* getChallengeStatusReceiverBoundsWithPadding NS_SWIFT_NAME(getChallengeStatusReceiverBoundsWithPadding);
- (NSString*)getChallengeStatusReceiverBoundsWithPadding NS_SWIFT_NAME(getChallengeStatusReceiverBoundsWithPadding());
- (void)stringObfuscationTestLoadImage :(NSString*)newChallengeDataEntry NS_SWIFT_NAME(stringObfuscationTestLoadImage(_:));

@property (nonatomic,readonly,assign,getter=challengeInfoTextDispatchQueue) NSString* challengeInfoTextDispatchQueue NS_SWIFT_NAME(challengeInfoTextDispatchQueue);
- (NSString*)challengeInfoTextDispatchQueue NS_SWIFT_NAME(challengeInfoTextDispatchQueue());

@property (nonatomic,readonly,assign,getter=advancedTimeoutInterval) NSString* advancedTimeoutInterval NS_SWIFT_NAME(advancedTimeoutInterval);
- (NSString*)advancedTimeoutInterval NS_SWIFT_NAME(advancedTimeoutInterval());

@property (nonatomic,readonly,assign,getter=getHeadingTextColorDeviceParameterBlacklist) NSString* getHeadingTextColorDeviceParameterBlacklist NS_SWIFT_NAME(getHeadingTextColorDeviceParameterBlacklist);
- (NSString*)getHeadingTextColorDeviceParameterBlacklist NS_SWIFT_NAME(getHeadingTextColorDeviceParameterBlacklist());

@property (nonatomic,readonly,assign,getter=getThreeDSRequestorAppURLFlexibleWidth) NSString* getThreeDSRequestorAppURLFlexibleWidth NS_SWIFT_NAME(getThreeDSRequestorAppURLFlexibleWidth);
- (NSString*)getThreeDSRequestorAppURLFlexibleWidth NS_SWIFT_NAME(getThreeDSRequestorAppURLFlexibleWidth());

@property (nonatomic,readonly,assign,getter=hexHashDirectoryServerInfo) int hexHashDirectoryServerInfo NS_SWIFT_NAME(hexHashDirectoryServerInfo);
- (int)hexHashDirectoryServerInfo NS_SWIFT_NAME(hexHashDirectoryServerInfo());

- (NSString*)insetVersion:(int)challengeSelectInfoIndex NS_SWIFT_NAME(insetVersion(_:));

- (NSString*)getAcsTransactionIDBlack:(int)challengeSelectInfoIndex NS_SWIFT_NAME(getAcsTransactionIDBlack(_:));

@property (nonatomic,readonly,assign,getter=requestIsRuntimeCodeTampered) NSString* requestIsRuntimeCodeTampered NS_SWIFT_NAME(requestIsRuntimeCodeTampered);
- (NSString*)requestIsRuntimeCodeTampered NS_SWIFT_NAME(requestIsRuntimeCodeTampered());

@property (nonatomic,readwrite,assign,getter=sockaddrGetSegment,setter=getChallengeTimeRemainingSetCornerRadius:) int sockaddrGetSegment NS_SWIFT_NAME(sockaddrGetSegment);
- (int)sockaddrGetSegment NS_SWIFT_NAME(sockaddrGetSegment());
- (void)getChallengeTimeRemainingSetCornerRadius :(int)newDeviceParamCount NS_SWIFT_NAME(getChallengeTimeRemainingSetCornerRadius(_:));

- (int)detectionClassBottom:(int)deviceParamIndex NS_SWIFT_NAME(detectionClassBottom(_:));
- (void)endifParamValue:(int)deviceParamIndex :(int)newDeviceParamCategory NS_SWIFT_NAME(endifParamValue(_:_:));

- (NSString*)checkDarwin:(int)deviceParamIndex NS_SWIFT_NAME(checkDarwin(_:));
- (void)joinedFontSize:(int)deviceParamIndex :(NSString*)newDeviceParamFieldName NS_SWIFT_NAME(joinedFontSize(_:_:));

- (NSString*)userDefaultChars:(int)deviceParamIndex NS_SWIFT_NAME(userDefaultChars(_:));
- (void)dsCAsInfoDict:(int)deviceParamIndex :(NSString*)newDeviceParamValue NS_SWIFT_NAME(dsCAsInfoDict(_:_:));

- (int)setupNavigationBarGetSeverity:(int)deviceParamIndex NS_SWIFT_NAME(setupNavigationBarGetSeverity(_:));
- (void)ptraceTypeButtonType:(int)deviceParamIndex :(int)newDeviceParamValueType NS_SWIFT_NAME(ptraceTypeButtonType(_:_:));

@property (nonatomic,readwrite,assign,getter=pageOffsetPrivKey,setter=nameAGetWarnings:) NSString* pageOffsetPrivKey NS_SWIFT_NAME(pageOffsetPrivKey);
- (NSString*)pageOffsetPrivKey NS_SWIFT_NAME(pageOffsetPrivKey());
- (void)nameAGetWarnings :(NSString*)newDirectoryServerCertEncoded NS_SWIFT_NAME(nameAGetWarnings(_:));

@property (nonatomic,readwrite,assign,getter=navBarResendChallenge,setter=uIViewMyClient:) NSData* navBarResendChallenge NS_SWIFT_NAME(navBarResendChallenge);
- (NSData*)navBarResendChallenge NS_SWIFT_NAME(navBarResendChallenge());
- (void)uIViewMyClient :(NSData*)newDirectoryServerCertEncoded NS_SWIFT_NAME(uIViewMyClient(_:));

@property (nonatomic,readwrite,assign,getter=nsectsEffect,setter=expandableInformationLabelThreeDSServerAuthRequest:) NSString* nsectsEffect NS_SWIFT_NAME(nsectsEffect);
- (NSString*)nsectsEffect NS_SWIFT_NAME(nsectsEffect());
- (void)expandableInformationLabelThreeDSServerAuthRequest :(NSString*)newDirectoryServerCertStore NS_SWIFT_NAME(expandableInformationLabelThreeDSServerAuthRequest(_:));

@property (nonatomic,readwrite,assign,getter=setTextWithIconForkRetCode,setter=cancelActionRandomArrary:) NSData* setTextWithIconForkRetCode NS_SWIFT_NAME(setTextWithIconForkRetCode);
- (NSData*)setTextWithIconForkRetCode NS_SWIFT_NAME(setTextWithIconForkRetCode());
- (void)cancelActionRandomArrary :(NSData*)newDirectoryServerCertStore NS_SWIFT_NAME(cancelActionRandomArrary(_:));

@property (nonatomic,readwrite,assign,getter=aCSRootCertCountGetAuthenticationRequestParameters,setter=getWarningsChallengeInfoTextIndicator:) NSString* aCSRootCertCountGetAuthenticationRequestParameters NS_SWIFT_NAME(aCSRootCertCountGetAuthenticationRequestParameters);
- (NSString*)aCSRootCertCountGetAuthenticationRequestParameters NS_SWIFT_NAME(aCSRootCertCountGetAuthenticationRequestParameters());
- (void)getWarningsChallengeInfoTextIndicator :(NSString*)newDirectoryServerCertStorePassword NS_SWIFT_NAME(getWarningsChallengeInfoTextIndicator(_:));

@property (nonatomic,readwrite,assign,getter=uIImageLanguageCode,setter=continueReadRange:) int uIImageLanguageCode NS_SWIFT_NAME(uIImageLanguageCode);
- (int)uIImageLanguageCode NS_SWIFT_NAME(uIImageLanguageCode());
- (void)continueReadRange :(int)newDirectoryServerCertStoreType NS_SWIFT_NAME(continueReadRange(_:));

@property (nonatomic,readwrite,assign,getter=cONTINUEFirstInstruction,setter=shouldStopSignedContent:) NSString* cONTINUEFirstInstruction NS_SWIFT_NAME(cONTINUEFirstInstruction);
- (NSString*)cONTINUEFirstInstruction NS_SWIFT_NAME(cONTINUEFirstInstruction());
- (void)shouldStopSignedContent :(NSString*)newDirectoryServerCertSubject NS_SWIFT_NAME(shouldStopSignedContent(_:));

@property (nonatomic,readwrite,assign,getter=provisionUrlDyldInfoCmd,setter=dispatchQoSInterface:) NSString* provisionUrlDyldInfoCmd NS_SWIFT_NAME(provisionUrlDyldInfoCmd);
- (NSString*)provisionUrlDyldInfoCmd NS_SWIFT_NAME(provisionUrlDyldInfoCmd());
- (void)dispatchQoSInterface :(NSString*)newDirectoryServerId NS_SWIFT_NAME(dispatchQoSInterface(_:));

@property (nonatomic,readonly,assign,getter=clearPcBase) NSString* clearPcBase NS_SWIFT_NAME(clearPcBase);
- (NSString*)clearPcBase NS_SWIFT_NAME(clearPcBase());

@property (nonatomic,readonly,assign,getter=useSDKProcessingScreenBoundsWithPadding) NSString* useSDKProcessingScreenBoundsWithPadding NS_SWIFT_NAME(useSDKProcessingScreenBoundsWithPadding);
- (NSString*)useSDKProcessingScreenBoundsWithPadding NS_SWIFT_NAME(useSDKProcessingScreenBoundsWithPadding());

@property (nonatomic,readonly,assign,getter=directoryServerInfoListParam) NSString* directoryServerInfoListParam NS_SWIFT_NAME(directoryServerInfoListParam);
- (NSString*)directoryServerInfoListParam NS_SWIFT_NAME(directoryServerInfoListParam());

@property (nonatomic,readwrite,assign,getter=eventImpDyldPath,setter=unsafePointerCheckAuthResponse:) int eventImpDyldPath NS_SWIFT_NAME(eventImpDyldPath);
- (int)eventImpDyldPath NS_SWIFT_NAME(eventImpDyldPath());
- (void)unsafePointerCheckAuthResponse :(int)newExtensionCount NS_SWIFT_NAME(unsafePointerCheckAuthResponse(_:));

- (BOOL)dyldWhiteListCategory:(int)extensionIndex NS_SWIFT_NAME(dyldWhiteListCategory(_:));
- (void)scaleAspectFitNlist:(int)extensionIndex :(BOOL)newExtensionCritical NS_SWIFT_NAME(scaleAspectFitNlist(_:_:));

- (NSString*)dlsymWhyInformationLabel:(int)extensionIndex NS_SWIFT_NAME(dlsymWhyInformationLabel(_:));
- (void)iconPositionLeftNewACSRootCertStoreType:(int)extensionIndex :(NSString*)newExtensionData NS_SWIFT_NAME(iconPositionLeftNewACSRootCertStoreType(_:_:));

- (NSString*)directoryServerCertStoreMonitor:(int)extensionIndex NS_SWIFT_NAME(directoryServerCertStoreMonitor(_:));
- (void)frameworkTEXTSectionAddrEndSetButtonText:(int)extensionIndex :(NSString*)newExtensionId NS_SWIFT_NAME(frameworkTEXTSectionAddrEndSetButtonText(_:_:));

- (NSString*)securityEventSetDeviceParamValue:(int)extensionIndex NS_SWIFT_NAME(securityEventSetDeviceParamValue(_:));
- (void)preIconViewSetHeadingTextColor:(int)extensionIndex :(NSString*)newExtensionName NS_SWIFT_NAME(preIconViewSetHeadingTextColor(_:_:));

@property (nonatomic,readonly,assign,getter=transStatusSeverity) NSString* transStatusSeverity NS_SWIFT_NAME(transStatusSeverity);
- (NSString*)transStatusSeverity NS_SWIFT_NAME(transStatusSeverity());

@property (nonatomic,readonly,assign,getter=dsIconSetAcsRefNumber) NSString* dsIconSetAcsRefNumber NS_SWIFT_NAME(dsIconSetAcsRefNumber);
- (NSString*)dsIconSetAcsRefNumber NS_SWIFT_NAME(dsIconSetAcsRefNumber());

@property (nonatomic,readonly,assign,getter=scaleAspectFitImpFramework) NSString* scaleAspectFitImpFramework NS_SWIFT_NAME(scaleAspectFitImpFramework);
- (NSString*)scaleAspectFitImpFramework NS_SWIFT_NAME(scaleAspectFitImpFramework());

@property (nonatomic,readwrite,assign,getter=IndirectsymoffCreateTransaction,setter=canceledFontAttributes:) BOOL IndirectsymoffCreateTransaction NS_SWIFT_NAME(IndirectsymoffCreateTransaction);
- (BOOL)IndirectsymoffCreateTransaction NS_SWIFT_NAME(IndirectsymoffCreateTransaction());
- (void)canceledFontAttributes :(BOOL)newOOBContinuationIndicator NS_SWIFT_NAME(canceledFontAttributes(_:));

@property (nonatomic,readonly,assign,getter=IsDebuggerAttachedNewMethod) NSString* IsDebuggerAttachedNewMethod NS_SWIFT_NAME(IsDebuggerAttachedNewMethod);
- (NSString*)IsDebuggerAttachedNewMethod NS_SWIFT_NAME(IsDebuggerAttachedNewMethod());

@property (nonatomic,readonly,assign,getter=enterMyHTTPS) NSString* enterMyHTTPS NS_SWIFT_NAME(enterMyHTTPS);
- (NSString*)enterMyHTTPS NS_SWIFT_NAME(enterMyHTTPS());

@property (nonatomic,readonly,assign,getter=selectedViewControllerNamelen) NSString* selectedViewControllerNamelen NS_SWIFT_NAME(selectedViewControllerNamelen);
- (NSString*)selectedViewControllerNamelen NS_SWIFT_NAME(selectedViewControllerNamelen());

@property (nonatomic,readonly,assign,getter=setHeadingTextAlignmentShouldFireChallengeStatusFirst) NSString* setHeadingTextAlignmentShouldFireChallengeStatusFirst NS_SWIFT_NAME(setHeadingTextAlignmentShouldFireChallengeStatusFirst);
- (NSString*)setHeadingTextAlignmentShouldFireChallengeStatusFirst NS_SWIFT_NAME(setHeadingTextAlignmentShouldFireChallengeStatusFirst());

@property (nonatomic,readwrite,assign,getter=clientTransactionID,setter=warningsUuidString:) int clientTransactionID NS_SWIFT_NAME(clientTransactionID);
- (int)clientTransactionID NS_SWIFT_NAME(clientTransactionID());
- (void)warningsUuidString :(int)newProxyAuthScheme NS_SWIFT_NAME(warningsUuidString(_:));

@property (nonatomic,readwrite,assign,getter=newACSRootCertStoreCurrentLocation,setter=configParameterToFile:) BOOL newACSRootCertStoreCurrentLocation NS_SWIFT_NAME(newACSRootCertStoreCurrentLocation);
- (BOOL)newACSRootCertStoreCurrentLocation NS_SWIFT_NAME(newACSRootCertStoreCurrentLocation());
- (void)configParameterToFile :(BOOL)newProxyAutoDetect NS_SWIFT_NAME(configParameterToFile(_:));

@property (nonatomic,readwrite,assign,getter=familyNamesGetAcsTransactionID,setter=sdkTransactionIDDenyRuntimeHook:) NSString* familyNamesGetAcsTransactionID NS_SWIFT_NAME(familyNamesGetAcsTransactionID);
- (NSString*)familyNamesGetAcsTransactionID NS_SWIFT_NAME(familyNamesGetAcsTransactionID());
- (void)sdkTransactionIDDenyRuntimeHook :(NSString*)newProxyPassword NS_SWIFT_NAME(sdkTransactionIDDenyRuntimeHook(_:));

@property (nonatomic,readwrite,assign,getter=closeViewToolbarTextColor,setter=hasSuspiciousJailbreakFilesEncryptedData:) int closeViewToolbarTextColor NS_SWIFT_NAME(closeViewToolbarTextColor);
- (int)closeViewToolbarTextColor NS_SWIFT_NAME(closeViewToolbarTextColor());
- (void)hasSuspiciousJailbreakFilesEncryptedData :(int)newProxyPort NS_SWIFT_NAME(hasSuspiciousJailbreakFilesEncryptedData(_:));

@property (nonatomic,readwrite,assign,getter=lazyBindingInfoStartCmdsize,setter=aCSUITypeGetGroup:) NSString* lazyBindingInfoStartCmdsize NS_SWIFT_NAME(lazyBindingInfoStartCmdsize);
- (NSString*)lazyBindingInfoStartCmdsize NS_SWIFT_NAME(lazyBindingInfoStartCmdsize());
- (void)aCSUITypeGetGroup :(NSString*)newProxyServer NS_SWIFT_NAME(aCSUITypeGetGroup(_:));

@property (nonatomic,readwrite,assign,getter=aCSHTMLRefreshBuild,setter=sdkTEXTSectionAddrStartStroff:) int aCSHTMLRefreshBuild NS_SWIFT_NAME(aCSHTMLRefreshBuild);
- (int)aCSHTMLRefreshBuild NS_SWIFT_NAME(aCSHTMLRefreshBuild());
- (void)sdkTEXTSectionAddrStartStroff :(int)newProxySSL NS_SWIFT_NAME(sdkTEXTSectionAddrStartStroff(_:));

@property (nonatomic,readwrite,assign,getter=formatUnsafePointer,setter=insetAdvanced:) NSString* formatUnsafePointer NS_SWIFT_NAME(formatUnsafePointer);
- (NSString*)formatUnsafePointer NS_SWIFT_NAME(formatUnsafePointer());
- (void)insetAdvanced :(NSString*)newProxyUser NS_SWIFT_NAME(insetAdvanced(_:));

@property (nonatomic,readonly,assign,getter=detectionClassWHITELIST) NSString* detectionClassWHITELIST NS_SWIFT_NAME(detectionClassWHITELIST);
- (NSString*)detectionClassWHITELIST NS_SWIFT_NAME(detectionClassWHITELIST());

@property (nonatomic,readwrite,assign,getter=IconViewDeviceParam,setter=pathsInline:) NSString* IconViewDeviceParam NS_SWIFT_NAME(IconViewDeviceParam);
- (NSString*)IconViewDeviceParam NS_SWIFT_NAME(IconViewDeviceParam());
- (void)pathsInline :(NSString*)newSDKAppId NS_SWIFT_NAME(pathsInline(_:));

@property (nonatomic,readwrite,assign,getter=RemainGetTextFontName,setter=httpMethodNewACSRootCertStore:) NSString* RemainGetTextFontName NS_SWIFT_NAME(RemainGetTextFontName);
- (NSString*)RemainGetTextFontName NS_SWIFT_NAME(RemainGetTextFontName());
- (void)httpMethodNewACSRootCertStore :(NSString*)newSDKTransactionId NS_SWIFT_NAME(httpMethodNewACSRootCertStore(_:));

@property (nonatomic,readwrite,assign,getter=NavigationControllerTitleEdgeInsets,setter=withAttributesClientLog:) NSString* NavigationControllerTitleEdgeInsets NS_SWIFT_NAME(NavigationControllerTitleEdgeInsets);
- (NSString*)NavigationControllerTitleEdgeInsets NS_SWIFT_NAME(NavigationControllerTitleEdgeInsets());
- (void)withAttributesClientLog :(NSString*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(withAttributesClientLog(_:));

@property (nonatomic,readwrite,assign,getter=LoadedDylibNameOffsetCustomization,setter=cleanupFramework:) NSData* LoadedDylibNameOffsetCustomization NS_SWIFT_NAME(LoadedDylibNameOffsetCustomization);
- (NSData*)LoadedDylibNameOffsetCustomization NS_SWIFT_NAME(LoadedDylibNameOffsetCustomization());
- (void)cleanupFramework :(NSData*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(cleanupFramework(_:));

@property (nonatomic,readwrite,assign,getter=ClientTestPorts,setter=ldrRegisterSUBMIT:) NSString* ClientTestPorts NS_SWIFT_NAME(ClientTestPorts);
- (NSString*)ClientTestPorts NS_SWIFT_NAME(ClientTestPorts());
- (void)ldrRegisterSUBMIT :(NSString*)newSSLCertEncoded NS_SWIFT_NAME(ldrRegisterSUBMIT(_:));

@property (nonatomic,readwrite,assign,getter=DlsymUsing,setter=forLabelTypeUserInterfaceIdiom:) NSData* DlsymUsing NS_SWIFT_NAME(DlsymUsing);
- (NSData*)DlsymUsing NS_SWIFT_NAME(DlsymUsing());
- (void)forLabelTypeUserInterfaceIdiom :(NSData*)newSSLCertEncoded NS_SWIFT_NAME(forLabelTypeUserInterfaceIdiom(_:));

@property (nonatomic,readwrite,assign,getter=EnsurePaddingMapNotNilBoundsWithPadding,setter=foundationFontName:) NSString* EnsurePaddingMapNotNilBoundsWithPadding NS_SWIFT_NAME(EnsurePaddingMapNotNilBoundsWithPadding);
- (NSString*)EnsurePaddingMapNotNilBoundsWithPadding NS_SWIFT_NAME(EnsurePaddingMapNotNilBoundsWithPadding());
- (void)foundationFontName :(NSString*)newSSLCertStore NS_SWIFT_NAME(foundationFontName(_:));

@property (nonatomic,readwrite,assign,getter=OnDataPacketOutRadius,setter=warningsNSAttributedString:) NSData* OnDataPacketOutRadius NS_SWIFT_NAME(OnDataPacketOutRadius);
- (NSData*)OnDataPacketOutRadius NS_SWIFT_NAME(OnDataPacketOutRadius());
- (void)warningsNSAttributedString :(NSData*)newSSLCertStore NS_SWIFT_NAME(warningsNSAttributedString(_:));

@property (nonatomic,readwrite,assign,getter=WriteStoredValidateDataKey,setter=getifaddrsUIKit:) NSString* WriteStoredValidateDataKey NS_SWIFT_NAME(WriteStoredValidateDataKey);
- (NSString*)WriteStoredValidateDataKey NS_SWIFT_NAME(WriteStoredValidateDataKey());
- (void)getifaddrsUIKit :(NSString*)newSSLCertStorePassword NS_SWIFT_NAME(getifaddrsUIKit(_:));

@property (nonatomic,readwrite,assign,getter=AnimatedCanceled,setter=forTimeIntervalAtomically:) int AnimatedCanceled NS_SWIFT_NAME(AnimatedCanceled);
- (int)AnimatedCanceled NS_SWIFT_NAME(AnimatedCanceled());
- (void)forTimeIntervalAtomically :(int)newSSLCertStoreType NS_SWIFT_NAME(forTimeIntervalAtomically(_:));

@property (nonatomic,readwrite,assign,getter=CheckTamperedByMobileProvisionHashDeviceParam,setter=greenDeviceParamCategory:) NSString* CheckTamperedByMobileProvisionHashDeviceParam NS_SWIFT_NAME(CheckTamperedByMobileProvisionHashDeviceParam);
- (NSString*)CheckTamperedByMobileProvisionHashDeviceParam NS_SWIFT_NAME(CheckTamperedByMobileProvisionHashDeviceParam());
- (void)greenDeviceParamCategory :(NSString*)newSSLCertSubject NS_SWIFT_NAME(greenDeviceParamCategory(_:));

@property (nonatomic,readonly,assign,getter=LowercasedImageData) NSString* LowercasedImageData NS_SWIFT_NAME(LowercasedImageData);
- (NSString*)LowercasedImageData NS_SWIFT_NAME(LowercasedImageData());

@property (nonatomic,readonly,assign,getter=UITypeEffect) NSData* UITypeEffect NS_SWIFT_NAME(UITypeEffect);
- (NSData*)UITypeEffect NS_SWIFT_NAME(UITypeEffect());

@property (nonatomic,readonly,assign,getter=threadScreenHeight) NSString* threadScreenHeight NS_SWIFT_NAME(threadScreenHeight);
- (NSString*)threadScreenHeight NS_SWIFT_NAME(threadScreenHeight());

@property (nonatomic,readwrite,assign,getter=myUILabelSetPadding,setter=getDefaultDSCAConfigParams:) int myUILabelSetPadding NS_SWIFT_NAME(myUILabelSetPadding);
- (int)myUILabelSetPadding NS_SWIFT_NAME(myUILabelSetPadding());
- (void)getDefaultDSCAConfigParams :(int)newTimeout NS_SWIFT_NAME(getDefaultDSCAConfigParams(_:));

@property (nonatomic,readonly,assign,getter=alertLdrRegister) NSString* alertLdrRegister NS_SWIFT_NAME(alertLdrRegister);
- (NSString*)alertLdrRegister NS_SWIFT_NAME(alertLdrRegister());

@property (nonatomic,readwrite,assign,getter=forkRetCodePtraceType,setter=isInDeviceParamBlacklistSecurityEventListener:) BOOL forkRetCodePtraceType NS_SWIFT_NAME(forkRetCodePtraceType);
- (BOOL)forkRetCodePtraceType NS_SWIFT_NAME(forkRetCodePtraceType());
- (void)isInDeviceParamBlacklistSecurityEventListener :(BOOL)newWhitelistingDataEntry NS_SWIFT_NAME(isInDeviceParamBlacklistSecurityEventListener(_:));

@property (nonatomic,readwrite,assign,getter=textCmdNameImageCount,setter=randomMessageVersion:) NSString* textCmdNameImageCount NS_SWIFT_NAME(textCmdNameImageCount);
- (NSString*)textCmdNameImageCount NS_SWIFT_NAME(textCmdNameImageCount());
- (void)randomMessageVersion :(NSString*)newWhitelistingInformationText NS_SWIFT_NAME(randomMessageVersion(_:));

@property (nonatomic,readonly,assign,getter=strideIndexArrary) NSString* strideIndexArrary NS_SWIFT_NAME(strideIndexArrary);
- (NSString*)strideIndexArrary NS_SWIFT_NAME(strideIndexArrary());

@property (nonatomic,readonly,assign,getter=completionHandlerStoredValidateData) NSString* completionHandlerStoredValidateData NS_SWIFT_NAME(completionHandlerStoredValidateData);
- (NSString*)completionHandlerStoredValidateData NS_SWIFT_NAME(completionHandlerStoredValidateData());

  /* Methods */

- (void)clientACSRootCertStoreTypesConfigParametersTests:(NSString*)field :(NSString*)value :(int)valueType :(int)category NS_SWIFT_NAME(clientACSRootCertStoreTypesConfigParametersTests(_:_:_:_:));
- (void)challengeSelectInfoCountAddress:(NSString*)id :(NSString*)name :(BOOL)critical :(NSString*)data NS_SWIFT_NAME(challengeSelectInfoCountAddress(_:_:_:_:));
- (void)systemBackgroundForFamilyName:(NSString*)name :(NSString*)value :(int)valueType NS_SWIFT_NAME(systemBackgroundForFamilyName(_:_:_:));
- (void)curSegnameNavItem:(NSString*)authResponse NS_SWIFT_NAME(curSegnameNavItem(_:));
- (NSString*)nSDataThrows:(NSString*)configurationString NS_SWIFT_NAME(nSDataThrows(_:));
- (NSString*)transactionStatusHeadingTextFontName NS_SWIFT_NAME(transactionStatusHeadingTextFontName());
- (void)withUnsafePointerSetButtonText NS_SWIFT_NAME(withUnsafePointerSetButtonText());
- (void)regionCodeGetJSONArrary NS_SWIFT_NAME(regionCodeGetJSONArrary());
- (void)remainingStrAddTarget NS_SWIFT_NAME(remainingStrAddTarget());
- (void)addSecurityParamsDladdr NS_SWIFT_NAME(addSecurityParamsDladdr());

@end