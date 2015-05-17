//
//  LogView.m
//  LePats
//
//  Created by xiongchi on 15-5-18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LogView.h"

@implementation LogView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGB(237, 237, 237).CGColor;
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 5.0f;
    [self setBackgroundColor:RGB(253, 252, 250)];
    [self initBody];
    return self;
}

-(void)initBody
{
    _txtUser = [[UITextField  alloc] initWithFrame:Rect(20, 10,self.frame.size.width-40, 30)];
    [self addSubview:_txtUser];
    [_txtUser setPlaceholder:@"输入昵称/手机/邮箱"];
    
    _txtPwd = [[UITextField alloc] initWithFrame:Rect(20, 60, self.frame.size.width-40, 30)];
    [self addSubview:_txtPwd];
    [_txtPwd setSecureTextEntry:YES];
    [_txtPwd setPlaceholder:@"输入密码"];
    [self addViewLine];
}

-(void)addViewLine
{
    
    UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0,49.5,self.frame.size.width,0.5)];
    sLine1.backgroundColor = [UIColor colorWithRed:237/255.0
                                             green:237/255.0
                                              blue:237/255.0
                                             alpha:1.0];
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0,50,self.frame.size.width, 0.5)] ;
    sLine2.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:sLine1];
    [self addSubview:sLine2];
 
}


@end
