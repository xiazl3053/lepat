//
//  MyPetsViewController.h
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    PetType_ADD,
    PetType_EDIT,
} PetType;

@interface AddPetViewController : BaseViewController
@property (nonatomic,assign) PetType type;
@property (nonatomic,assign) int nPetId;
@end
