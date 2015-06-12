//
//  ChineseString.h
//  ChineseSort
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PetSortModel;

@interface ChineseString : NSObject

@property(strong,nonatomic) NSString *string;
@property(strong,nonatomic) NSString *pinYin;
@property(nonatomic,strong) PetSortModel *petSon;

@end
