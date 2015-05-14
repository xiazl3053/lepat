//
//  RegisterService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"


typedef void(^HttpRequestCode)(int nStatus,NSString *strCode);


@interface RegisterService : HttpManager


@property (nonatomic,copy) HttpRequestCode httpCode;


-(void)requestReg:(NSString *)strCode mobile:(NSString *)strMobile;

-(void)requestRegCode:(NSString *)strMobile;

@end
