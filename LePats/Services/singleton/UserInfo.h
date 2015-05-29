//
//  UserInfo.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

DEFINE_SINGLETON_FOR_HEADER(UserInfo);

@property (nonatomic,strong) NSString *strToken;
@property (nonatomic,strong) NSString *strMobile;
@property (nonatomic,strong) NSString *strNickName;
@property (nonatomic,strong) NSString *strPassword;
@property (nonatomic,strong) NSString *strUserId;
@property (nonatomic,strong) NSString *strBirthday;
@property (nonatomic,assign) int  nSex;
@property (nonatomic,strong ) NSString *strCode;
@property (nonatomic,strong) NSString *strUserIcon;


@property (nonatomic,strong) NSString *strSignature;


-(void)setLoginUser:(NSDictionary *)strInfo;

@end
