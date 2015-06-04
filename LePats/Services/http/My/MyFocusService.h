//
//  MyFocusService.h
//  LePats
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

@interface MyFocusService : HttpManager
-(void)requestUserId:(int)nUserId;
@end
