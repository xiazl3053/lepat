//
//  FocusService.m
//  LePats
//
//  Created by xiongchi on 15-6-4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FocusService.h"
#import "UserInfo.h"

@implementation FocusService


-(void)requestFocus:(NSString *)strUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/focus/focusUser.do?oper_user_id=%@&userid=%@&token=%@%@",LEPAT_HTTP_HOST,strUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus != 200)
    {
        return ;
    }
    DLog(@"dict:%@",dict);
    int nType = [[dict objectForKey:@"return_code"] intValue];
    if (nType == 10000)
    {
        if (_httpFocus)
        {
            _httpFocus(1,@"OK");
        }
    }
    else
    {
        if (_httpFocus)
        {
            NSString *strMsg = [dict objectForKey:@"return_msg"];
            _httpFocus(nType,strMsg);
        }
    }
}

@end
