//
//  MyPetTableViewCell.h
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LePetInfo.h"
@interface MyPetTableViewCell : UITableViewCell
-(void)setValueWithPetInfo:(LePetInfo *)pet;
@end
