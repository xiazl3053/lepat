//
//  RegSecondVIewController.m
//  LePats
//
//  Created by xiongchi on 15-5-20.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RegSecondVIewController.h"
#import "UserInfo.h"
#import "ProgressHUD.h"
#import "UIView+Extension.h"
#import "RegisterService.h"
#import "Toast+UIView.h"

@interface RegSecondViewController()
{
    UITextField *txtMobile;
    RegisterService *regServer;
}
@end

@implementation RegSecondViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"填写验证码";
    
    UILabel *lblInfo = [[UILabel alloc] initWithFrame:Rect(11, 80, 280, 20)];
    [lblInfo setFont:XCFONT(14)];
    NSString *strInfo = [NSString stringWithFormat:@"已经发送验证到:%@",[UserInfo sharedUserInfo].strMobile];
    [lblInfo setText:strInfo];
    [lblInfo setTextColor:RGB(0,0,0)];
    [self.view addSubview:lblInfo];
    
    txtMobile = [[UITextField alloc] initWithFrame:Rect(11, 120, 200, 40)];
    [txtMobile.layer setMasksToBounds:YES];
    txtMobile.layer.cornerRadius = 2.0f;
    [txtMobile setBackgroundColor:RGB(253,252,250)];
    [txtMobile setTextColor:RGB(0, 0, 0)];
    [self.view addSubview:txtMobile];
    [txtMobile setPlaceholder:@"请输入验证码"];
    txtMobile.layer.borderColor = RGB(230, 230, 230).CGColor;
    txtMobile.layer.borderWidth = 1;
    
    UIView *viewNumber = [[UIView alloc] initWithFrame:Rect(0, 0, 20, 20)];
    txtMobile.leftView = viewNumber;
    txtMobile.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtMobile.leftViewMode = UITextFieldViewModeAlways;
    txtMobile.keyboardType = UIKeyboardTypePhonePad;
    [txtMobile setBorderStyle:UITextBorderStyleNone];
    
    UIButton *btnSender = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnSender];
    [btnSender setTitle:@"重新发送" forState:UIControlStateNormal];
    btnSender.frame = Rect(220,120,self.view.width-231,40);
    [btnSender setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btnSender.layer.borderWidth = 1;
    btnSender.layer.borderColor = RGB(230, 230, 230).CGColor;
    [btnSender.layer setMasksToBounds:YES];
    btnSender.layer.cornerRadius = 2.0f;
    
    [self setRightHidden:NO];
    [self setRightTitle:@"下一步"];
    
    
}

-(void)reSendCode
{
    if (regServer == nil)
    {
        regServer = [[RegisterService alloc] init];
    }
    [ProgressHUD show:@"重新发送"];
    regServer.httpCode= ^(int nStatus,NSString *strCode)
    {
        switch (nStatus) {
            case 1:
            {
                
            }
            break;
            default:
            {
            }
            break;
        }
    };
    [regServer requestRegCode:[UserInfo sharedUserInfo].strMobile];
}

-(void)regOK
{
   if (regServer == nil)
    {
        regServer = [[RegisterService alloc] init];
    }
    [ProgressHUD show:@"注册中..."];
    regServer.httpReg = ^(int nStatus)
    {
        switch (nStatus) {
            case 1:
            {
                DLog(@"注册成功");
            }
            break;
            default:
            {
                
            }
            break;
        }
    };
    [regServer requestReg:txtMobile.text mobile:[UserInfo sharedUserInfo].strMobile];
}


@end
