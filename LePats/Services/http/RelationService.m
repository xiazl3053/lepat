//
//  RelationService.m
//  LePats
//
//  Created by admin on 15/6/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RelationService.h"
#import "UserInfo.h"

@implementation RelationService

-(void)requestOperId:(NSString *)strUserId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    //pets/user/getInfo.do?userid=51&token=xxxadminxxx&v=1_0&oper_user_id=50
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/focus/getRelation.do?oper_user_id=%@&userid=%@&token=%@%@",LEPAT_HTTP_HOST,strUserId
                        ,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"getInfo.do");
        return ;
    }
    NSLog(@"%@",dic);
    if (self.relationBlock)
    {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            self.relationBlock(nil,[[dic objectForKey:@"relation"]intValue]);
        }else
        {
            self.relationBlock([dic objectForKey:KServiceResponseMsg],-1);
        }
    }
}


@end
