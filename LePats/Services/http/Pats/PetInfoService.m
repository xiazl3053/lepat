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
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/getPetInfo.do?petId=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nPetId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的宠物信息错误");
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.petInfoBlock) {
        self.petInfoBlock(nil,dic);
    }
}

@end
