//
//  HomeItemCollectionCell.h
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItemModel.h"

@class HomeItemCollectionCell;
@class HomeItemButton;

@protocol HomeItemCollectionCellDelegate <NSObject>

-(void)homeItemCollectionCell:(HomeItemCollectionCell *)cell userClickHomeItemButton:(HomeItemButton *)btn;

@end

@interface HomeItemCollectionCell : UICollectionViewCell

-(void)setItemModel:(HomeItemModel *)model;

@property (nonatomic,assign) id<HomeItemCollectionCellDelegate> delegate;

@end
