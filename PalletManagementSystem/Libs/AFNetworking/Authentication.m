//
//  Authentication.m
//  CPFApp
//
//  Created by HaiChau on 5/8/15.
//  Copyright (c) 2015 William Karminten. All rights reserved.
//

#import "Authentication.h"

@implementation Authentication
static NSMutableArray *sharedConnectionList = nil;

-(id)initWithRequest:(NSString*)urlString {

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *temp = @"grant_type=certificate";
    request.HTTPMethod =@"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[temp dataUsingEncoding:NSUTF8StringEncoding]];
    self = [super init];
    if (self) {
        [self setRequest:request];
    }
    return self;
}

-(void)start {
    
    responseData = [[NSMutableData alloc]init];
    internalConnection = [[NSURLConnection alloc]initWithRequest:[self request] delegate:self startImmediately:YES];
    if(!sharedConnectionList)
        sharedConnectionList = [[NSMutableArray alloc] init];
    [sharedConnectionList addObject:self];
    [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:3000"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];

    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //NSLog(@"in didReceiveData ");
    [responseData appendData:data];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (NSURLCredential *)credentialWithIdentity:(SecIdentityRef)identity certificates:(NSArray *)certArray persistence:(NSURLCredentialPersistence)persistence {
    
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"sit-MobileServiceClient" ofType:@"pfx"];
    NSData *certData   = [[NSData alloc] initWithContentsOfFile:certPath];
    
    SecIdentityRef myIdentity = NULL;  // ???
    
    SecCertificateRef myCert = SecCertificateCreateWithData(NULL, (CFDataRef)CFBridgingRetain(certData));
    SecCertificateRef certArray1[1] = { myCert };
    CFArrayRef myCerts = CFArrayCreate(NULL, (void *)certArray1, 1, NULL);
    CFRelease(myCert);
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity
                                                             certificates:(__bridge NSArray *)myCerts
                                                              persistence:NSURLCredentialPersistencePermanent];
    CFRelease(myCerts);
    return credential;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //NSLog(@"in didReceiveAuthenticationChallenge ");
    
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"sit-MobileServiceClient" ofType:@"pfx"];
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:thePath];
    CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
    SecIdentityRef identity;
    [self extractIdentity :inPKCS12Data :&identity];
    
    SecCertificateRef certificate = NULL;
    SecIdentityCopyCertificate (identity, &certificate);
    
    const void *certs[] = {certificate};
    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
    
    NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
    [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"in connectionDidFinishLoading ");
    if([self completitionBlock])
        [self completitionBlock](responseData,nil);
    
    [sharedConnectionList removeObject:self];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"in didFailWithError ");
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    if([self completitionBlock])
        [self completitionBlock](nil,error);
    
    [sharedConnectionList removeObject:self];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;     // Never cache
}

- (OSStatus)extractIdentity:(CFDataRef)inP12Data :(SecIdentityRef*)identity {
    OSStatus securityError = errSecSuccess;
    
    CFStringRef password = CFSTR("cpfb2014");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12Data, options, &items);
    
    if (securityError == 0) {
        CFDictionaryRef ident = CFArrayGetValueAtIndex(items,0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(ident, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
    }
    
    if (options) {
        CFRelease(options);
    }
    
    return securityError;
}

@end
