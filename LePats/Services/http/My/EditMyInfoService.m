//
//  EditMyInfoService.m
//  LePats
//
//  Created by admin on 15/5/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "EditMyInfoService.h"
#import "UserInfo.h"

@implementation EditMyInfoService

/*
 *"nickname：昵称
 sex：性别
 birthday：生日
 signature：签名
 password:密码"
 */

-(void)requestEditSex
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?sex=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.nSex,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)requestEditBrithday
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?birthday=%@&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.strBirthday,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)requestEditNickName
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?nickname=%@&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.strNickName,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    //[self sendRequest:strUrl];
    [self sendRequestString:LEPAT_HTTP_HOST url:strUrl];
}

-(void)requestEditPasssword{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?password=%@&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.strPassword,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)requestEditSingture{
    UserInfo *user = [UserInfo sharedUserInfo];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do",LEPAT_HTTP_HOST];

    
    NSString *post = [NSString stringWithFormat:@"signature=%@&userid=%@&token=%@%@",
                        user.strSignature,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    //[self sendRequest:strUrl];
     [self sendRequestString:post  url:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"更改我的信息错误");
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.editMyInfoBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            self.editMyInfoBlock(nil);
        }else{
            self.editMyInfoBlock([dic objectForKey:KServiceResponseMsg]);
        }
    }
}

@end
