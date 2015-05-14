//
//  LoginService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpLoginService)(int nStatus);

@interface LoginService : HttpManager


@property (nonatomic,copy) HttpLoginService httpBlock;

-(void)requestLogin:(NSString *)strUser password:(NSString *)strPwd;

@end
