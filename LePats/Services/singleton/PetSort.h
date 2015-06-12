//
//  PetSort.h
//  LePats
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetSort : NSObject

DEFINE_SINGLETON_FOR_HEADER(PetSort);

@property (nonatomic,strong) NSMutableArray *petListArr;
@property (nonatomic,strong) NSMutableArray *aryKey;
@property (nonatomic,strong) NSMutableArray *aryInfo;

-(void)setPetListArr:(NSArray *)petList;

-(NSString *)getPetNameWithiD:(int )iD;

@end
