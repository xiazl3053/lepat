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
#import "RegSettingViewController.h"




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
    txtMobile.keyboardType = UIKeyboardTypeDefault;
    [txtMobile setBorderStyle:UITextBorderStyleNone];
    
    UIButton *btnSender = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnSender];
    [btnSender setTitle:@"重新发送" forState:UIControlStateNormal];
    btnSender.frame = Rect(220,120,self.view.width-231,40);
    [btnSender setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btnSender.layer.borderWidth = 1;
//    btnSender.layer.borderColor = RGB(230, 230, 230).CGColor;
    [btnSender.layer setMasksToBounds:YES];
    btnSender.layer.cornerRadius = 2.0f;
    
    [self setRightHidden:NO];
    [self setRightTitle:@"下一步"];
    __weak RegSecondViewController *__self = self;
    [self addRightEvent:^(id sender)
     {
         [__self regOK];
     }];
    [btnSender addTarget:self
                  action:@selector(reSendCode) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regSucessBack) name:MESSAGE_UPDATE_USER_VC object:nil];
}

-(void)regSucessBack
{
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_UPDATE_USER_T_VC object:nil];
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)reSendCode
{
    if (regServer == nil)
    {
        regServer = [[RegisterService alloc] init];
    }
    [ProgressHUD show:@"重新发送"];
    __weak RegSecondViewController *__self = self;
    regServer.httpCode= ^(int nStatus,NSString *strCode)
    {
        dispatch_async(dispatch_get_main_queue(), ^{[ProgressHUD dismiss];});
        __strong RegSecondViewController *__strongSelf = __self;
        switch (nStatus) {
            case 200:
            {
                DLog(@"发送成功");
                dispatch_async(dispatch_get_main_queue(), ^{[__strongSelf.view makeToast:@"重新发送成功"];
                });
            }
            break;
            default:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [__strongSelf.view makeToast:@"发送失败"];
                });
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
    __weak RegSecondViewController *__self = self;
    regServer.httpReg = ^(int nStatus)
    {
        dispatch_async(dispatch_get_main_queue(), ^{[ProgressHUD dismiss];});
        NSString *strMsg = nil;
        switch (nStatus) {
            case 200:
            {
                DLog(@"注册成功");
                strMsg = @"注册成功";
            }
            break;
            case 50001:
            {
                DLog(@"已经注册");
                strMsg = @"手机已经注册";
            }
            default:
            {
                DLog(@"请求出现错误");
                strMsg = @"注册超时";
            }
            break;
        }
        __strong RegSecondViewController *__strongSelf = __self;
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [__strongSelf.view makeToast:strMsg];
        });
        if (nStatus == 200)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),
            ^{
                  //注册到另外一个界面
                RegSettingViewController *regSetting = [[RegSettingViewController alloc] init];
                [__strongSelf presentViewController:regSetting animated:YES completion:nil];
            });
        }
    };
    [regServer requestReg:txtMobile.text mobile:[UserInfo sharedUserInfo].strMobile];
}


@end
