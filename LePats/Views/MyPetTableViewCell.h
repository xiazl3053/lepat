//
//  MyPetTableViewCell.h
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LePetInfo.h"

@protocol MyPetTableViewCellDelegate;

@interface MyPetTableViewCell : UITableViewCell
-(void)setValueWithPetInfo:(LePetInfo *)pet;
@property (nonatomic,assign) id<MyPetTableViewCellDelegate> delegate;
@end

@protocol MyPetTableViewCellDelegate <NSObject>
-(void)MyPetTableViewCell:(MyPetTableViewCell *)cell clickMap:(UIButton *)aBut;

@end