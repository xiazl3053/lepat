//
//  PetInfoService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"
#import "LePetInfo.h"

typedef void(^GetPetInfoBlock)(NSString *error,LePetInfo *pet);

@interface PetInfoService : HttpManager

-(void)requestPetInfo:(int)nPetId;

@property (nonatomic,copy) GetPetInfoBlock getPetInfoBlock;

@end
