//
//  UpdUserService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UpdUserService.h"

#import "UserInfo.h"

@implementation UpdUserService


-(void)updReqUserInfo
{
    UserInfo *user = [UserInfo sharedUserInfo];
    //%@pats/user/setInfo.do?nickname=%@&sex=%d&birthday=%@&signature=0&password=%@userid=%@token=%@%@
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/setInfo.do?nickname=%@&sex=%d&birthday=%@&password=%@&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,user.strNickName,user.nSex,user.strBirthday,user.strPassword,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        if (_httpBlock) {
            _httpBlock(*nStatus);
        }
        return ;
    }
    DLog(@"dic:%@",dic);
    int nReturnCode = [[dic objectForKey:@"return_code"] intValue];
    if (nReturnCode == 10000) {
        if (_httpBlock)
        {
            _httpBlock(200);
        }
    }
    else
    {
        if (_httpBlock)
        {
            _httpBlock(nReturnCode);
        }
    }
}

@end
