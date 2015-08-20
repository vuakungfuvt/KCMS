//
//  Authentication.h
//  CPFApp
//
//  Created by HaiChau on 5/8/15.
//  Copyright (c) 2015 William Karminten. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Authentication : NSObject  <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSURLConnection * internalConnection;
    NSMutableData *responseData;
    }

-(id)initWithRequest:(NSString*)urlString;
@property (nonatomic,copy)NSMutableURLRequest *request;
@property (nonatomic,copy)void (^completitionBlock) (NSData *data, NSError * err);


-(void)start;
@end
