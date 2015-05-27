//
//  DelPetService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^DelPetBlock)(NSString *error);

@interface DelPetService : HttpManager

-(void)requestDelPetInfo:(int)nPetId;
@property (nonatomic,copy) DelPetBlock delPetBlock;

@end
