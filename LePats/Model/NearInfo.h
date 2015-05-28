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
@property (nonatomic,assign) CGFloat fAtti;

-(id)initWithItems:(NSArray *)items;


@end
