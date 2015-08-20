//
//  GetDataRequest.h
//  CPFApp
//
//  Created by HaiChau on 6/3/15.
//  Copyright (c) 2015 William Karminten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "AFNetworking.h"
#import "Authentication.h"
#import "LoginInfo.h"

@interface ProcessRequest : NSObject{
    BOOL isGetToken;
}
- (void)getData:(NSString *)xmlString withCompletitionBlock:(void (^)( id responseObject))success
        failure:(void (^)(NSError *err))failure;
- (void)getCalData:(NSString *)xmlString withCompletitionBlock:(void (^)( id responseObject))success
           failure:(void (^)(NSError *err))failure;
- (void)getURLLoginwithCompletitionBlock:(void (^)( id responseObject))success
                                 failure:(void (^)(NSString *loginURL))failure;
@end
