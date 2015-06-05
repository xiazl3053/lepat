//
//  TUserService.m
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TUserService.h"
#import "UserInfo.h"
#import "NearInfo.h"

@implementation TUserService


-(void)requestOperId:(NSString *)strUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    //pets/user/getInfo.do?userid=51&token=xxxadminxxx&v=1_0&oper_user_id=50
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/user/getInfo.do?oper_user_id=%@&userid=%@&token=%@%@",LEPAT_HTTP_HOST,strUserId
                        ,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus!=200)
    {
        DLog(@"getInfo.do");
        return ;
    }
    int nType = [[dict objectForKey:@"return_code"] intValue];
    if (nType == 10000)
    {
        NSDictionary *dicTemp = [dict objectForKey:@"user"];
        NearInfo *nearInfo = [[NearInfo alloc] initWithDic:dicTemp];
        DLog(@"dicTemp:%@",dicTemp);
        if (_httpBlock)
        {
            _httpBlock(1,nearInfo);
        }
    }
}
@end
