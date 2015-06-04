//
//  MyFansService.m
//  LePats
//
//  Created by admin on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyFansService.h"
#import "UserInfo.h"
#import "FansModel.h"

@implementation MyFansService

-(void)requestUserId:(int)nUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/focus/getFans.do?oper_user_id=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
    
    if (nUserId==0) {
       
    }
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的粉丝错误");
        return ;
    }
    if (self.myFansServiceBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            NSArray *list=[dic objectForKey:@"fansList"];
            NSMutableArray *data=[NSMutableArray array];
            for (NSDictionary *obj in list) {
                NSLog(@"%@",obj);
                FansModel *model=[[FansModel alloc]initWithDic:obj];
                [data addObject:model];
            }
            self.myFansServiceBlock(nil,data);
        }else{
            self.myFansServiceBlock([dic objectForKey:KServiceResponseMsg],nil);
        }
        
    }else{
        NSLog(@"self.myFansServiceBlock为nil");
    }
    
}


@end
