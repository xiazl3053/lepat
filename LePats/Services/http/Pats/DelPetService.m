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
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/doDel.do?petId=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nPetId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveInfo:(int *)nStatus data:(NSData *)data
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的宠物信息错误");
        return ;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    DLog(@"dic:%@",dic);
}


@end
