//
//  TheyInfoService.m
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TheyInfoService.h"
#import "LePetInfo.h"
#import "UserInfo.h"

@implementation TheyInfoService

-(void)requestUserId:(NSString *)strUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/pet/getPetByUser.do?oper_user_id=%@&userid=%@&token=%@%@",LEPAT_HTTP_HOST,strUserId
                        ,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus!=200)
    {
        DLog(@"查询经纬度信息");
        return ;
    }
    int nType = [[dict objectForKey:@"return_code"] intValue];
    if (nType == 10000)
    {
        NSArray *aryTemp = [dict objectForKey:@"petByUList"];
        NSMutableArray *item = [NSMutableArray array];
        for (NSDictionary *petDic in aryTemp)
        {
            LePetInfo *lePet = [[LePetInfo alloc] initWithNSDictionary:petDic];
            [item addObject:lePet];
        }
        if (_httpBlock)
        {
            _httpBlock(1,item);
        }
    }
}


@end
