//
//  PetSortService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetSortService.h"
#import "UserInfo.h"
#import "PetSortModel.h"

@implementation PetSortService

-(void)requestPetSort
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/petsort/getPetSort.do?userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取宠物分类错误");
        return ;
    }
    DLog(@"dic:%@",dic);
    NSMutableArray *data=[NSMutableArray array];
    for (NSDictionary *dic in [dic objectForKey:@"petList"]) {
        PetSortModel *model=[[PetSortModel alloc]initWithNSDictionary:dic];
        [data addObject:model];
    }
    if (self.getPetSortBlock) {
        self.getPetSortBlock(nil,data);
    }
}






@end
