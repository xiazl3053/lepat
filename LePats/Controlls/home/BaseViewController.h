//
//  BaseViewController.h
//  LePats
//
//  Created by admin on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIControl+BlocksKit.h"

@interface BaseViewController : UIViewController
@property(assign,nonatomic)NSInteger returnType;
@property(assign,nonatomic)UIView *backView;//标题栏顶部背景蒙版
@property(assign,nonatomic)UILabel *lable;//标题栏的标题
@property(assign,nonatomic)UIView *topLine;//top的底部分割线
@property(assign,nonatomic)UIButton *returnBtn;//返回键


-(void)setLeftHidden:(BOOL)bHidden;

-(void)setRightHidden:(BOOL)bHidden;

-(void)setRightTitle:(NSString *)strTitle;

-(void)setRightImg:(NSString *)strNor high:(NSString *)strHigh select:(NSString *)strSelect;

-(void)addRightEvent:(void (^)(id sender))handler;
//-(void)addTag:
@end
