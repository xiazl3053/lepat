//
//  PetSortService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetSortService.h"

#import "UserInfo.h"

@implementation PetSortService

-(void)requestPetSort
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/petsort/getPetSort.do?userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveInfo:(int *)nStatus data:(NSData *)data
{
    if (*nStatus!=200)
    {
        DLog(@"获取宠物分类错误");
        return ;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    DLog(@"dic:%@",dic);
}
@end
