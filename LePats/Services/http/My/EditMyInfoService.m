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

-(void)requestEditMyInfo
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?nickname=%@&sex=%d&birthday=%@&signature=%@&password=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.strNickName,user.nSex,user.strBirthday,user.strSignature,user.strPassword,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
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
