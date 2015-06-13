//
//  MyFocusService.m
//  LePats
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyFocusService.h"
#import "UserInfo.h"
#import "FansModel.h"
#import "NearInfo.h"

@implementation MyFocusService
-(void)requestUserId:(int)nUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/focus/getFocus.do?oper_user_id=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
    
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的关注错误");
        if (self.focusServiceBlock)
        {
            self.focusServiceBlock(nil,nil);
        }
        return ;
    }
    if (self.focusServiceBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            NSArray *list=[dic objectForKey:@"focusList"];
            NSMutableArray *data=[NSMutableArray array];
            for (NSDictionary *obj in list) {
                NSLog(@"%@",obj);
                NearInfo *info=[[NearInfo alloc]initWithDic:obj];
                [data addObject:info];
            }
            self.focusServiceBlock(nil,data);
        }else{
            self.focusServiceBlock([dic objectForKey:KServiceResponseMsg],nil);
        }
        
    }else{
        NSLog(@"self.focusServiceBlock为nil");
    }

}


@end
