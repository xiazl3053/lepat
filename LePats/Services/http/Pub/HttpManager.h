//
//  HttpManager.h
//  XCMonit_Ip
//
//  Created by 夏钟林 on 15/3/6.
//  Copyright (c) 2015年 夏钟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject

-(void)sendRequest:(NSString*)strPath;

-(void)reciveDic:(int*)nStatus dic:(NSDictionary*)dict;

-(void)sendRequestData:(NSData*)data url:(NSString *)strUrl;

-(void)sendRequestString:(NSString *)strInfo url:(NSString *)strUrl;

-(BOOL)isConnection:(NSDictionary *)dict;
@end
