//
//  Pet.m
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetSortModel.h"

@implementation PetSortModel

-(id)initWithNSDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.createtime=[dic objectForKey:@"createtime"];
        self.iD=[dic objectForKey:@"id"];
        self.modtime=[dic objectForKey:@"modtime"];
        self.name=[dic objectForKey:@"name"];
        self.superId=[dic objectForKey:@"superId"];
    }
    return self;
}

@end
