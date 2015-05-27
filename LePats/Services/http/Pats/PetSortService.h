//
//  PetSortService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^GetPetSortBlock)(NSString *error,NSArray *data);

@interface PetSortService : HttpManager

-(void)requestPetSort;
@property (nonatomic,copy) GetPetSortBlock getPetSortBlock;

@end
