//
//  PetInfoService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetInfoService.h"
#import "UserInfo.h"

@implementation PetInfoService

-(void)requestPetInfo:(int)nPetId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/pet/getPetInfo.do?petId=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nPetId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的宠物信息错误");
        if (self.getPetInfoBlock)
        {
            self.getPetInfoBlock(nil,nil);
        }
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.getPetInfoBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            LePetInfo *info=[[LePetInfo alloc]initWithNSDictionary:[dic objectForKey:@"pet"]];
            self.getPetInfoBlock(nil,info);
        }else{
            self.getPetInfoBlock([dic objectForKey:KServiceResponseMsg],nil);
        }
    }
}

@end
