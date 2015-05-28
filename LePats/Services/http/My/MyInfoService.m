//
//  MyInfoService.m
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyInfoService.h"
#import "UserInfo.h"

@implementation MyInfoService
-(void)requestUserId:(int)nUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/getInfo.do?oper_user_id=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的信息错误");
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.getMyInfoBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            self.getMyInfoBlock(nil);
        }else{
            self.getMyInfoBlock([dic objectForKey:KServiceResponseMsg]);
        }
    }
}
@end
