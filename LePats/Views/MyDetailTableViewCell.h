//
//  MyDetailCellTableViewCell.h
//  LePats
//
//  Created by admin on 15/5/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetailTableViewCell : UITableViewCell
-(void)setValueWithNSDictionay:(NSDictionary *)dic;

@property (nonatomic,strong) UITextField *content;
@property (nonatomic,strong) UIImageView *indicate;
@property (nonatomic,strong) UILabel *title;

@end
