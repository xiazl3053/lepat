//
//  RegisterService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RegisterService.h"
#import "UserInfo.h"
#import "UpdUserService.h"

@implementation RegisterService

-(void)requestReg:(NSString *)strCode mobile:(NSString *)strMobile
{
    NSString *strUrl = [NSString stringWithFormat:@"%@pub/regMobile.do?check_msg=%@&mobile=%@%@",LEPAT_HTTP_HOST,strCode,strMobile,LEPAT_VERSION_INFO];
    
    [self sendRequest:strUrl];
}

-(void)requestRegCode:(NSString *)strMobile
{
     NSString *strUrl = [NSString stringWithFormat:@"%@pub/getMobileCheckMsg.do?mobile=%@%@",LEPAT_HTTP_HOST,strMobile,LEPAT_VERSION_INFO];
    
    [self sendRequest:strUrl];
}

-(void)reciveInfo:(int *)nStatus data:(NSData *)data
{
    if(*nStatus==200)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        int status = [[dic objectForKey:@"return_code"] intValue];
        DLog(@"status:%d",status);
        if (status==10000)
        {
            NSArray *aryInfo = [dic objectForKey:@"check_msg"];
            if (aryInfo)
            {
                //验证码
                NSString *strInfo = [NSString stringWithFormat:@"%@%@%@%@",aryInfo[0],aryInfo[1],aryInfo[2],aryInfo[3]];
                DLog(@"验证码是:%@",strInfo);
                [self requestReg:strInfo mobile:@"13712345678"];
            }
            else
            {
                if([dic objectForKey:@"token"])
                {
                    NSDictionary *dicInfo = [dic objectForKey:@"loginuser"];
                    [[UserInfo sharedUserInfo] setLoginUser:dicInfo];
                    [UserInfo sharedUserInfo].strToken = [dic objectForKey:@"token"];
                    DLog(@"注册成功:%@",[dicInfo objectForKey:@"userid"]);
                    //修改帐号信息
                    
                    [UserInfo sharedUserInfo].strPassword = @"123456";
                    [UserInfo sharedUserInfo].strNickName = @"test";
                    [UserInfo sharedUserInfo].strBirthday = @"1970-1-1";
                    
                    UpdUserService *updService = [[UpdUserService alloc] init];
                    [updService updReqUserInfo];
//
                }
            }
        }
        else
        {
            DLog(@"dic:%@",dic);
        }
    }
    else
    {
        
    }
    
    
}


@end
