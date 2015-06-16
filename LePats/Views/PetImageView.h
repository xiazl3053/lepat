//
//  PetImageView.h
//  LePats
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LePetInfo.h"
@interface PetImageView : UIImageView
@property (nonatomic,strong) LePetInfo *petInfo;
@end
