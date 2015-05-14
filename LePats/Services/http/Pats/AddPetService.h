//
//  AddPetService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

#import "LePetInfo.h"
@interface AddPetService : HttpManager

-(void)requestAddPet:(LePetInfo*)lePet;

@end
