//
//  AddPetService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

#import "LePetInfo.h"

typedef void(^AddPetBlock)(NSString *error);
@interface AddPetService : HttpManager

-(void)requestAddPet:(LePetInfo*)lePet;
@property (nonatomic,copy) AddPetBlock addPetBlock;

@end
