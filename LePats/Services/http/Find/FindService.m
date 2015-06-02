//
//  FindService.m
//  LePats
//
//  Created by xiongchi on 15-5-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FindService.h"
#import "UserInfo.h"
#import "NearInfo.h"


@implementation FindService

-(void)requestFindNear:(CGFloat)fLat lng:(CGFloat)fLng
{
    UserInfo *user = [UserInfo sharedUserInfo];
//    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/getPetByUser.do?pageNum=%d&pageSize=20&userid=%@&token=%@%@",
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/user/getNear.do?lat=%f&lng=%f&userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        fLat,fLng,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus!=200)
    {
        DLog(@"查询经纬度信息");
        return ;
    }
    DLog(@"dic:%@",dict);
    
    int nType = [[dict objectForKey:@"return_code"] intValue];
    if (nType == 10000)
    {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *obj in [dict objectForKey:@"userList"])
        {
            NearInfo *info=[[NearInfo alloc] initWithDic:obj];
            [data addObject:info];
        }
        if (_httpBlock)
        {
            _httpBlock(1,data);
        }
    }
    
}

@end
