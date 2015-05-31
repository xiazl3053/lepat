//
//  UserInfo.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

DEFINE_SINGLETON_FOR_CLASS(UserInfo);

-(void)setLoginUser:(NSDictionary *)dicInfo
{
    _strUserId = [dicInfo objectForKey:@"userid"];
    _strPassword = [dicInfo objectForKey:@"password"];
    _strMobile = [dicInfo objectForKey:@"mobile"];
    _strNickName = [dicInfo objectForKey:@"nickname"];
    _nSex = [[dicInfo objectForKey:@"sex"] intValue];
    _strBirthday = [dicInfo objectForKey:@"birthday"];
    _strSignature=[dicInfo objectForKey:@"signature"];
    _strUserIcon=[dicInfo objectForKey:@"userIcon"];
    _strFansNum=[dicInfo objectForKey:@"fansNum"];
    _strFocusNum=[dicInfo objectForKey:@"focusNum"];
    _strUserIcon=[dicInfo objectForKey:@"userIcon"];
}

@end
