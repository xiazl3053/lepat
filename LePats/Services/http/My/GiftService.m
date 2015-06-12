//
//  GiftService.m
//  LePats
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "GiftService.h"
#import "UserInfo.h"

@implementation GiftService

-(void)requestGiftWithID:(int)nUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/gift/userGift.do?oper_user_id=%d&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,nUserId,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"获取我的礼品错误");
        if (self.giftServiceBlock)
        {
            self.giftServiceBlock(nil,nil);
        }
        return ;
    }
    
    NSLog(@"获取我的礼品=%@",dic);
    if (self.giftServiceBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            NSArray *list=[dic objectForKey:@"focusList"];
            NSMutableArray *data=[NSMutableArray array];
            for (NSDictionary *obj in list) {
                NSLog(@"%@",obj);
            }
            self.giftServiceBlock(nil,data);
        }else{
            self.giftServiceBlock([dic objectForKey:KServiceResponseMsg],nil);
        }
        
    }else{
        NSLog(@"self.focusServiceBlock为nil");
    }
    
}

@end
