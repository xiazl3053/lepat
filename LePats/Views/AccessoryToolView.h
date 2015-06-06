//
//  AccosoryToolView.h
//  LePats
//
//  Created by admin on 15/6/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AccessoryToolViewClickBlock)(NSInteger index);

@interface AccessoryToolView : UIView

@property (nonatomic,copy) AccessoryToolViewClickBlock accessoryToolViewClickBlock;


@end
