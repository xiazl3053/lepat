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

-(id)initWithItems:(NSArray *)items;

-(id)initWithDic:(NSDictionary *)dict;

@end
