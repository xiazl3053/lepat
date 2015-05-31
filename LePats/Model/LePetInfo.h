//
//  LePetInfo.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PET_SEX_MALE,
    PET_SEX_FEMALE,
} PET_SEX;

@interface LePetInfo : NSObject
/*
petId:宠物ID
petName：宠物名称
petCount：拥有宠物数量
birthday：生日
sortId：宠物分类id
description：宠物描述
sex：性别
*/
@property (nonatomic,assign) int nPetId;
@property (nonatomic,strong) NSString *strName;
@property (nonatomic,assign) int nPetCount;
@property (nonatomic,strong) NSString *strBirthday;
@property (nonatomic,assign) int nSortId;
@property (nonatomic,strong) NSString *strDescription;
@property (nonatomic,assign) int nSex;
@property (nonatomic,assign) int nPhotoId;
@property (nonatomic,copy)  NSString *strIconUrl;


-(id)initWithNSDictionary:(NSDictionary *)dic;

@end
