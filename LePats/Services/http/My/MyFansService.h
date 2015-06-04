//
//  MyFansService.h
//  LePats
//
//  Created by admin on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^MyFansServiceBlock)(NSString *error,NSArray *list);
@interface MyFansService : HttpManager
-(void)requestUserId:(int)nUserId;
@property (nonatomic ,copy)MyFansServiceBlock myFansServiceBlock;
@end
