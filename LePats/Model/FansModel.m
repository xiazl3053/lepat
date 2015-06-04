//
//  FansModel.m
//  LePats
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FansModel.h"

@implementation FansModel

-(id)initWithDic:(NSDictionary *)dict{
    if (self=[super init]) {
        self.strUserId=[dict objectForKey:@"userid"];
        self.strName=[dict objectForKey:@"nickname"];
        self.strSignature=[dict objectForKey:@"signature"];
        self.strUserIcon=[dict objectForKey:@"userIcon"];
    }
    return self;
}

@end
