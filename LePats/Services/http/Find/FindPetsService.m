//
//  FindPetsService.m
//  LePats
//
//  Created by xiongchi on 15-6-4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FindPetsService.h"
#import "UserInfo.h"
#import "NearInfo.h"

@implementation FindPetsService

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus!=200)
    {
        DLog(@"查询经纬度信息");
        if (_httpBlock)
        {
            _httpBlock(*nStatus,nil);
        }
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
    else if(nType == 50003)
    {
        if (_httpBlock)
        {
            _httpBlock(50003,nil);
        }
    }
    else
    {
        if (_httpBlock)
        {
            _httpBlock(nType,nil);
        }
    }
}

-(void)requestPetLocation:(CGFloat)fLat long:(CGFloat)fLng type:(int)nType
{
     UserInfo *user = [UserInfo sharedUserInfo];//pets/user/getNearByUserPets.do
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/user/getNearByUserPets.do?lat=%f&lng=%f&userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        fLat,fLng,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];   
}

-(void)requestPetLocation:(CGFloat)fLat long:(CGFloat)fLng
{
    UserInfo *user = [UserInfo sharedUserInfo];//pets/user/getNearByUserPets.do
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/user/getNearByUserPets.do?lat=%f&lng=%f&userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        fLat,fLng,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    DLog(@"strUrl:%@",strUrl);
    [self sendRequest:strUrl];
}

@end
