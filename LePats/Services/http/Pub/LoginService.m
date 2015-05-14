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

-(void)reciveInfo:(int *)nStatus data:(NSData *)data
{
    DLog(@"nStatus:%d",*nStatus);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if (*nStatus==200)
    {
        if([dic objectForKey:@"token"])
        {
            NSDictionary *dicInfo = [dic objectForKey:@"loginuser"];
            [[UserInfo sharedUserInfo] setLoginUser:dicInfo];
            [UserInfo sharedUserInfo].strToken = [dic objectForKey:@"token"];
        }
    }
    else
    {
        return ;
    }
}

-(void)requestLogin:(NSString *)strUser password:(NSString *)strPwd
{
    NSString *strUrl = [NSString stringWithFormat:@"%@pub/login.do?mobile=%@&password=%@%@",LEPAT_HTTP_HOST,strUser,strPwd,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

@end
