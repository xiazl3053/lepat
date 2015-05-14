//
//  LoginService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService

-(void)reciveHttp:(NSURLResponse *)response data:(NSData *)data error:(NSError *)connectionError
{
    
}


-(void)requestLogin:(NSString *)strUser password:(NSString *)strPwd
{
    NSString *strUrl = [NSString stringWithFormat:@"%@pub/login.do?mobile=%@&password=%@",LEPAT_HTTP_HOST,strUser,strPwd];
    [self sendRequest:strUrl];
    
}

@end
