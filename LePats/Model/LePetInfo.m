//
//  LePetInfo.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LePetInfo.h"

@implementation LePetInfo

-(id)initWithNSDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.strBirthday=[dic objectForKey:@"birthday"];
        self.strDescription=[dic objectForKey:@"description"];
        self.strName=[dic objectForKey:@"petName"];
        self.nSex=[[dic objectForKey:@"sex"]intValue];
        self.nSortId=[[dic objectForKey:@"sortId"]intValue];
        self.nPetId=[[dic objectForKey:@"id"]intValue];
        self.strIconUrl=[dic objectForKey:@"iconUrl"];
    }
    return self;
}

@end
