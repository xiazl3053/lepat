//
//  PetSort.m
//  LePats
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetSort.h"
#import "PetSortModel.h"

@implementation PetSort

DEFINE_SINGLETON_FOR_CLASS(PetSort);

-(void)setPetListArr:(NSArray *)petListArr
{
    for (PetSortModel *model in petListArr)
    {
        DLog(@"model_name:%@--id:%@--superid:%@",model.name,model.iD,model.superId);
    }
    _petListArr=petListArr;
}

-(NSString *)getPetNameWithiD:(int)iD{
    for (PetSortModel *model in _petListArr)
    {
        if ([model.iD intValue]==iD) {
            return model.name;
        }
    }
    return @"";
}

@end
