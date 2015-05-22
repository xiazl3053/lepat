//
//  LoginService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginService.h"

#import "UserInfo.h"

@implementation LoginService

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus == 200)
    {
        if([dict objectForKey:@"token"])
        {
            NSDictionary *dicInfo = [dict objectForKey:@"loginuser"];
            [[UserInfo sharedUserInfo] setLoginUser:dicInfo];
            [UserInfo sharedUserInfo].strToken = [dict objectForKey:@"token"];
            [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_LOGIN_SUC_VC object:nil];
            if (_httpBlock)
            {
                _httpBlock(200);
            }
        }
        else
        {
            NSString *strReturnCode = [dict objectForKey:@"return_code"];
            if (_httpBlock)
            {
                _httpBlock([strReturnCode intValue]);
            }
 
        }
        return ;
    }
    else
    {
        if (_httpBlock) {
            _httpBlock(*nStatus);
        }
    }
}

-(void)requestLogin:(NSString *)strUser password:(NSString *)strPwd
{
    NSString *strUrl = [NSString stringWithFormat:@"%@pub/login.do?mobile=%@&password=%@%@",LEPAT_HTTP_HOST,strUser,strPwd,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

@end
