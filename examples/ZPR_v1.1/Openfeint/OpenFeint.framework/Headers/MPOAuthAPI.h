//
//  MPOAuthAPI.h
//  MPOAuthConnection
//
//  Created by Karl Adam on 08.12.05.
//  Copyright 2008 matrixPointer. All rights reserved.
//

// - http://code.google.com/p/mpoauthconnection/source/checkout

#import <Foundation/Foundation.h>
#import "MPOAuthCredentialStore.h"
#import "MPOAuthParameterFactory.h"


extern NSString *MPOAuthNotificationRequestTokenReceived;
extern NSString *MPOAuthNotificationAccessTokenReceived;
extern NSString *MPOAuthNotificationAccessTokenRefreshed;
extern NSString *MPOAuthNotificationOAuthCredentialsReady;
extern NSString *MPOAuthNotificationErrorHasOccurred;

typedef enum {
	MPOAuthSignatureSchemePlainText,
	MPOAuthSignatureSchemeHMACSHA1,
	MPOAuthSignatureSchemeRSASHA1
} MPOAuthSignatureScheme;

@protocol MPOAuthAPIDelegate;

@protocol MPOAuthAPIInternalClient
@end

@class MPOAuthCredentialConcreteStore;
@class MPOAuthAPIRequestLoader;
@class OFInvocation;

@interface MPOAuthAPI : NSObject <MPOAuthAPIInternalClient> {
	@private
	MPOAuthCredentialConcreteStore	*_credentials;
	NSURL							*_baseURL;
	NSURL							*_authenticationURL;
	NSURL							*_oauthRequestTokenURL;
	NSURL							*_oauthAuthorizeTokenURL;
	NSURL							*_oauthGetAccessTokenURL;
	MPOAuthSignatureScheme			_signatureScheme;
	NSMutableArray					*_activeLoaders;
	id <MPOAuthAPIDelegate>			_delegate;
	NSTimer							*_refreshTimer;
}

@property (nonatomic, readonly, retain) NSURL *baseURL;
@property (nonatomic, readonly, retain) NSURL *authenticationURL;
@property (nonatomic, readwrite, assign) MPOAuthSignatureScheme signatureScheme;
@property (nonatomic, readwrite, assign) id <MPOAuthAPIDelegate> delegate;

@property (nonatomic, readwrite, retain) NSURL *oauthRequestTokenURL;
@property (nonatomic, readwrite, retain) NSURL *oauthAuthorizeTokenURL;
@property (nonatomic, readwrite, retain) NSURL *oauthGetAccessTokenURL;

- (id)initWithCredentials:(NSDictionary *)inCredentials andBaseURL:(NSURL *)inURL;
- (id)initWithCredentials:(NSDictionary *)inCredentials authenticationURL:(NSURL *)inAuthURL andBaseURL:(NSURL *)inBaseURL;

- (void)removeAllCredentials;

- (MPOAuthAPIRequestLoader*)createLoaderForRequestToken;
- (MPOAuthAPIRequestLoader*)createLoaderForAccessToken;
- (NSString*)getRequestToken;
- (NSString*)getAccessToken;

- (BOOL)isAuthenticated;

- (void)setAccessToken:(NSString*)token andSecret:(NSString*)secret;

- (MPOAuthAPIRequestLoader*)createLoaderForMethod:(NSString *)inMethod atURL:(NSURL *)inURL withParameters:(NSArray *)inParameters withHttpMethod:(NSString*)httpMethod 
                            withSuccessInvocation:(OFInvocation*)onSuccess withFailureInvocation:(OFInvocation*)onFailure;
- (void)performMethod:(NSString *)inMethod withSuccessInvocation:(OFInvocation*)onSuccess withFailureInvocation:(OFInvocation*)onFailed;
- (void)performMethod:(NSString *)inMethod atURL:(NSURL *)inURL withParameters:(NSArray *)inParameters 
        withSuccessInvocation:(OFInvocation*)onSuccess withFailureInvocation:(OFInvocation*)onFailure;
- (void)performMethod:(NSString *)inMethod atURL:(NSURL *)inURL withParameters:(NSArray *)inParameters withHttpMethod:(NSString*)httpMethod 
        withSuccessInvocation:(OFInvocation*)onSuccess withFailureInvocation:(OFInvocation*)onFailure;

- (NSData *)dataForMethod:(NSString *)inMethod;
- (NSData *)dataForMethod:(NSString *)inMethod withParameters:(NSArray *)inParameters;
- (NSData *)dataForURL:(NSURL *)inURL andMethod:(NSString *)inMethod withParameters:(NSArray *)inParameters;
@end


@protocol MPOAuthAPIDelegate <NSObject>
- (NSURL *)callbackURLForCompletedUserAuthorization;
- (BOOL)automaticallyRequestAuthenticationWithToken:(NSString *)requestToken;
@end
