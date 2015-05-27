//
//  PetInfoEditService.h
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"
#import "LePetInfo.h"
typedef void(^EditPetBlock)(NSString *error);

@interface PetInfoEditService : HttpManager
@property (nonatomic,copy) EditPetBlock editPetBlock;
-(void)requestEditPet:(LePetInfo*)lePet;
@end
