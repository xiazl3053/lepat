//
//  FansModel.h
//  LePats
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FansModel : NSObject

@property (nonatomic,strong) NSString *strName;
@property (nonatomic,strong) NSString *strPet;
@property (nonatomic,strong) NSString *strContent;
@property (nonatomic,strong) NSString *strFile;
@property (nonatomic,assign) CGFloat fDistan;
@property (nonatomic,assign) int nSex;
@property (nonatomic,assign) CGFloat fLat;
@property (nonatomic,assign) CGFloat fLong;
@property (nonatomic,strong) NSString *strUserId;
@property (nonatomic,strong) NSString *strUserIcon;
@property (nonatomic,strong) NSString *strSignature;


@end
