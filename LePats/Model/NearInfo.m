//
//  NearInfo.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NearInfo.h"

@implementation NearInfo

-(id)initWithItems:(NSArray *)items
{
    self = [super init];
//@property (nonatomic,strong) NSString *strName;
//@property (nonatomic,strong) NSString *strPet;
//@property (nonatomic,strong) NSString *strContent;
//@property (nonatomic,assign) CGFloat
    return self;
}

-(id)initWithDic:(NSDictionary *)dict
{
    self = [super init];
    
    _strContent = [dict objectForKey:@"signature"];
    _fDistan = [[dict objectForKey:@"distan"] floatValue];
    _strName = [dict objectForKey:@"nickname"];
    _strFile = [dict objectForKey:@"userIcon"];
    _nSex = [[dict objectForKey:@"sex"] intValue];
    _fLat = [[dict objectForKey:@"lat"] floatValue];
    _fLong = [[dict objectForKey:@"lng"] floatValue];
    _strUserId = [dict objectForKey:@"userid"];
    _nFocus = [[dict objectForKey:@"relation"] intValue]/10;
    return self;
    
}

@end
