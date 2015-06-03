//
//  FocusService.h
//  LePats
//
//  Created by xiongchi on 15-6-4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpRequestFocus)(int nStatus,NSString *strMsg);


@interface FocusService : HttpManager

@property (nonatomic,copy) HttpRequestFocus httpFocus;

-(void)requestFocus:(NSString *)strUserId;


@end
