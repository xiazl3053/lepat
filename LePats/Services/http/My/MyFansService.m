//
//  MyFansService.m
//  LePats
//
//  Created by admin on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyFansService.h"
#import "UserInfo.h"

@implementation MyFansService

-(void)requestUserId:(int)nUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    if (nUserId==0) {
        NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/getInfo.do?userid=%@&token=%@%@",
                            LEPAT_HTTP_HOST,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
        [self sendRequest:strUrl];
    }else{
        NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/getInfo.do?oper_user_id=%d&userid=%@&token=%@%@",
                            LEPAT_HTTP_HOST,nUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
        [self sendRequest:strUrl];
    }
    //[self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的信息错误");
        return ;
    }
}


@end
