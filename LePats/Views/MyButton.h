//
//  MyButton.h
//  LePats
//
//  Created by admin on 15/6/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserOperationModel.h"

@interface MyButton : UIButton
-(void)setValueWithUserOperationModel:(UserOperationModel *)model;
-(void)setValueWithNumber:(NSString *)number;

@end
