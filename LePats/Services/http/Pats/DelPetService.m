//
//  DelPetService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "DelPetService.h"
#import "UserInfo.h"

@implementation DelPetService


-(void)requestDelPetInfo:(int)nPetId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/pet/doDel.do?petId=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nPetId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的宠物信息错误");
        if (_delPetBlock)
        {
            _delPetBlock(KLinkServiceErrorMsg);
        }
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.delPetBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            self.delPetBlock(nil);
        }else{
            self.delPetBlock([dic objectForKey:KServiceResponseMsg]);
        }
    }
}


@end
