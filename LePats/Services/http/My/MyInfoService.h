//
//  MyInfoService.h
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^GetMyInfoBlock)(NSString *error);

@interface MyInfoService : HttpManager
-(void)requestUserId:(int)nUserId;
@property (nonatomic,copy) GetMyInfoBlock getMyInfoBlock;
@end
