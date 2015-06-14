//
//  NearInfo.h
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearInfo : NSObject

@property (nonatomic,strong) NSString *strName;
@property (nonatomic,strong) NSString *strPet;
@property (nonatomic,strong) NSString *strContent;
@property (nonatomic,strong) NSString *strFile;
@property (nonatomic,assign) CGFloat fDistan;
@property (nonatomic,assign) int nSex;
@property (nonatomic,assign) CGFloat fLat;
@property (nonatomic,assign) CGFloat fLong;
@property (nonatomic,strong) NSString *strUserId;
@property (nonatomic,assign) int nFocus;
@property (nonatomic,assign) int nFansNum;
@property (nonatomic,assign) int nFocusNum;
@property (nonatomic,copy) NSString *strSignature;
@property (nonatomic,assign) int nRelation;

-(id)initWithItems:(NSArray *)items;

-(id)initWithDic:(NSDictionary *)dict;

@end
