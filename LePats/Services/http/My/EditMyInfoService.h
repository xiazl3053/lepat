//
//  EditMyInfoService.h
//  LePats
//
//  Created by admin on 15/5/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^EditMyInfoBlock)(NSString *error);

@interface EditMyInfoService : HttpManager
@property (nonatomic,copy) EditMyInfoBlock editMyInfoBlock;

-(void)requestEditSex;
-(void)requestEditNickName;
-(void)requestEditPasssword;
-(void)requestEditSingture;
-(void)requestEditBrithday;

@end
