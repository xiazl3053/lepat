//
//  UserInfo.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface UserInfo : NSObject


DEFINE_SINGLETON_FOR_HEADER(UserInfo);

@property (nonatomic,strong) NSString *strToken;
@property (nonatomic,strong) NSString *strMobile;
@property (nonatomic,strong) NSString *strNickName;
@property (nonatomic,strong) NSString *strPassword;
@property (nonatomic,strong) NSString *strUserId;
@property (nonatomic,strong) NSString *strBirthday;
@property (nonatomic,assign) int  nSex;
@property (nonatomic,assign) int  nScore;
@property (nonatomic,strong ) NSString *strCode;
@property (nonatomic,strong) NSString *strUserIcon;
@property (nonatomic,copy) NSString *strFocusNum;
@property (nonatomic,copy) NSString *strFansNum;
@property (nonatomic,strong) NSString *strSignature;
@property (nonatomic,assign) int nIsOpen;


-(void)setLoginUser:(NSDictionary *)strInfo;

-(double)getDistan:(CLLocationCoordinate2D)dStart end:(CLLocationCoordinate2D)dEnd;

@end
