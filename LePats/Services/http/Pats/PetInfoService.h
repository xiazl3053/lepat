//
//  PetInfoService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^PetInfoBlock)(NSString *error,NSDictionary *dic);

@interface PetInfoService : HttpManager

-(void)requestPetInfo:(int)nPetId;

@property (nonatomic,copy) PetInfoBlock petInfoBlock;

@end
