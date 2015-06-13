//
//  RecordTableViewCell.h
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
@interface RecordTableViewCell : UITableViewCell
-(void)setValueWithRecordModel:(RecordModel *)model;
@end
