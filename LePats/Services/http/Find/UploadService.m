//
//  UploadService.m
//  LePats
//
//  Created by xiongchi on 15-5-26.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UploadService.h"

#import "UserInfo.h"

@implementation UploadService




-(void)requestUploadLocation:(CGFloat)fLat lng:(CGFloat)fLng
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/user/getNear.do?lat=%f&lng=%f&userid=%@&token=%@%@",LEPAT_HTTP_HOST,
                        fLat,fLng,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    [self sendRequest:strUrl];
    
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    if (*nStatus!=200) {
        DLog(@"连接失败");
        return ;
    }
    DLog(@"");
}

@end
