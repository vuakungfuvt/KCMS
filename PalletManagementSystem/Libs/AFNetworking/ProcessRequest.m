//
//  GetDataRequest.m
//  CPFApp
//
//  Created by HaiChau on 6/3/15.
//  Copyright (c) 2015 William Karminten. All rights reserved.
//

#import "ProcessRequest.h"
#define CERT_FILE @"temp"
@implementation ProcessRequest
-(id)init
{
    if((self = [super init])){
        
    }
    return self;
}
- (void)getData:(NSString *)xmlString withCompletitionBlock:(void (^)( id responseObject))success
                         failure:(void (^)(NSError *err))failure {
    Global* myGlobal = [Global sharedGlobal];
    NSString* url = myGlobal.srvURL;
    LoginInfo* myLoginInfo = [LoginInfo sharedLoginInfo];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    //TODO: Add COokie to header here.
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [request setHTTPShouldHandleCookies:YES];
    [self addCookies:cookies forRequest:request];

    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.timeoutInterval = 60.0f;
    requestOperation.securityPolicy.allowInvalidCertificates = YES;

//    requestOperation.securityPolicy.pinnedCertificates
    // Configure Request Operation
    //TODO: Add certificate here, remove authentication.
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        //- Changes for Item 1 start
        if (!isGetToken && ([operation.response statusCode] == (int)401 || [operation.response statusCode] == NSURLErrorUserCancelledAuthentication)) {
            isGetToken = YES;
            Authentication * authentication2 = [[Authentication alloc]initWithRequest:myGlobal.serverGetToken];
            [authentication2 setCompletitionBlock:^(NSData *data, NSError *err) {
            }];
            [authentication2 start];

            Authentication * authentication = [[Authentication alloc]initWithRequest:myGlobal.serverGetToken];
            [authentication setCompletitionBlock:^(NSData *data, NSError *err) {
                if (!err) {
                    NSMutableDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    NSString *access_token =  [NSString stringWithFormat:@"%@ %@",[dictResponse objectForKey:@"token_type"],[dictResponse objectForKey:@"access_token"]];
                    if (access_token) {
                        myLoginInfo.accessTokenString = access_token;
                        [self getData:xmlString withCompletitionBlock:^(id responseObject) {
                            if (success) {
                                success(responseObject);
                            }
                        } failure:^(NSError *err) {
                            if (failure) {
                                failure(err);
                            }
                        }];
                        
                    }
                    
                } else {
                    if (failure) {
                        failure(error);
                    }
                }
            }];
            [authentication start];
            
        } else {
            if (failure) {
                failure(error);
            }
        }
    }];
   
    [requestOperation start];

}

- (void)getCalData:(NSString *)xmlString withCompletitionBlock:(void (^)( id responseObject))success
        failure:(void (^)(NSError *err))failure {
    Global* myGlobal = [Global sharedGlobal];
    NSString* url = myGlobal.calURL;
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [request setHTTPShouldHandleCookies:YES];
    [self addCookies:cookies forRequest:request];

    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.timeoutInterval = 60.0f;
    // Configure Request Operation
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        //- Changes for Item 1 start
            if (failure) {
                failure(error);
            }
    }];
    
    [requestOperation start];
    
}

- (void)getURLLoginwithCompletitionBlock:(void (^)( id responseObject))success
           failure:(void (^)(NSString *loginURL))failure {
    Global* myGlobal = [Global sharedGlobal];
    NSString* url = myGlobal.srvURL;
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
    // add Cookies to HTTP Request header
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [request setHTTPShouldHandleCookies:YES];
    [self addCookies:cookies forRequest:request];
    //create Params
    NSMutableDictionary *xmlParams = [NSMutableDictionary dictionaryWithCapacity:0];
    [xmlParams setValue:@"" forKey:@"TransactionType"];
    [xmlParams setValue:@"" forKey:@"CpfAccountNumber"];
    [xmlParams setValue:@"" forKey:@"RequestMessage"];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithObject:xmlParams forKey:@"MobileRequestModel"];
    NSString *xmlString = [myGlobal converXMLFromNSDictionary:tempDic];
    
    [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    // insert Cert file to request
//    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:CERT_FILE ofType:@"cer"];
//    
//    NSData *certData = [[NSData alloc] initWithContentsOfFile:fileRoot];
//    
////    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//    AFSecurityPolicy *mySecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [mySecurityPolicy setAllowInvalidCertificates:YES];
//    [mySecurityPolicy setPinnedCertificates:[[NSArray alloc] initWithObjects:certData, nil]];
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    request.timeoutInterval = 60.0f;
//    requestOperation.securityPolicy = mySecurityPolicy;
    
    // Configure Request Operation
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle Error
        //- Return login URL if statusCode return 401
        if (([operation.response statusCode] == (int)401 || [operation.response statusCode] == NSURLErrorUserCancelledAuthentication)) {
            NSLog(@"%@",operation.response.allHeaderFields);
            NSLog(@"%@",[[operation.response.allHeaderFields objectForKey:@"Www-Authenticate"] substringFromIndex:25]);
            failure([[operation.response.allHeaderFields objectForKey:@"Www-Authenticate"] substringFromIndex:25]);
        } else {
            if (failure) {
                failure(@"");
            }
        }
    }];
    
    [requestOperation start];
    
}

/**
 *  add cookies
 *
 *  @param cookies
 *  @param request
 */
- (void)addCookies:(NSArray *)cookies forRequest:(NSMutableURLRequest *)request
{
    if ([cookies count] > 0)
    {
        NSHTTPCookie *cookie;
        NSString *cookieHeader = nil;
        for (cookie in cookies)
        {
            if (!cookieHeader)
            {
                cookieHeader = [NSString stringWithFormat: @"%@=%@",[cookie name],[cookie value]];
            }
            else
            {
                cookieHeader = [NSString stringWithFormat: @"%@; %@=%@",cookieHeader,[cookie name],[cookie value]];
            }
        }
        if (cookieHeader)
        {
            [request setValue:cookieHeader forHTTPHeaderField:@"Cookie"];
        }
    }
}


@end
