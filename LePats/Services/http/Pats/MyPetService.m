//
//  MyPetService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyPetService.h"

#import "UserInfo.h"

@implementation MyPetService


-(void)requestPetInfo:(int)nCur
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/getPetByUser.do?pageNum=%d&pageSize=20&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nCur,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
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
    if (self.myPetsBlock) {
        self.myPetsBlock(nil,[dic objectForKey:@"petByUList"]);
    }
}

@end
