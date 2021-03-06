//
//  LoginViewController.m
//  LePats
//
//  Created by admin on 15/5/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "LogView.h"
#import "ProgressHUD.h"
#import "Toast+UIView.h"
#import "LoginService.h"
#import "UIView+Extension.h"
#import "RegFirstViewController.h"

@interface LoginViewController()
{
    LogView *loginView;
    LoginService *loginSer;
    BOOL bTokenShow;
}
@end


@implementation LoginViewController

-(void)show
{
    bTokenShow = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];
}

-(id)init
{
    self = [super init];
    
    
    return self;
}

-(void)backRegSucc
{
    if (bTokenShow)
    {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        return;
    }
    if (self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(250, 250, 250)];
    loginView = [[LogView alloc] initWithFrame:Rect(10, 120,self.view.frame.size.width-20, 100)];
    [self.view addSubview:loginView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backRegSucc) name:MESSAGE_UPDATE_USER_TH_VC object:nil];
    __weak LoginViewController *__self = self;
    self.title = @"登录";
    [self addLeftEvent:^(id sender)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [__self backRegSucc];
         });
     }];
    [self setRightHidden:NO];
    [self setRightTitle:@"注册"];
    [self addRightEvent:^(id sender)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [__self comeToReg];
        });
    }];
    UILabel *lblName = [[UILabel alloc] initWithFrame:Rect(50, 74, kScreenSourchWidth-100, 20)];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setFont:XCFONT(14)];
    [lblName setTextColor:RGB(102, 102, 102)];
    
    [lblName setText:@"乐水族账号登录"];
    [self.view addSubview:lblName];
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin setBackgroundColor:RGB(0, 146, 255)];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginServer) forControlEvents:UIControlEventTouchUpInside];
    btnLogin.frame = Rect(10,loginView.y+loginView.height+20,kScreenSourchWidth-20,40);
    [btnLogin.layer setMasksToBounds:YES];
    btnLogin.layer.cornerRadius = 3.0f;
    btnLogin.titleLabel.font = XCFONT(14);
    [self.view addSubview:btnLogin];
}

-(void)comeToReg
{
    RegFirstViewController *regFirst = [[RegFirstViewController alloc] init];
    [self presentViewController:regFirst animated:YES completion:nil];
}


-(void)loginServer
{
    if(loginSer==nil)
    {
        loginSer = [[LoginService alloc] init];
    }
    NSString *strUser = loginView.txtUser.text;
    NSString *strPwd = loginView.txtPwd.text;
    
    if ([strUser isEqualToString:@""])
    {
        [self.view makeToast:@"用户名不能为空"];
        return ;
    }
    if ([strPwd isEqualToString:@""])
    {
        [self.view makeToast:@"密码不能为空"];
        return ;
    }
    [ProgressHUD show:@"正在登录..."];
    __weak LoginViewController *__self = self;
    loginSer.httpBlock = ^(int nStatus)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        NSString *strMsg = nil;
        switch (nStatus) {
            case 200:
            {
                strMsg = @"登录成功";
            }
            break;
            case 50001:
            {
                DLog(@"登录失败，用户名或者密码错误");
                strMsg = @"登录失败，用户名或者密码错误";
            }
            break;
            default:
            {
                DLog(@"连接服务器错误");
                strMsg = @"连接服务器错误";
            }
            break;
        }
        __strong LoginViewController *__strongSelf = __self;
        dispatch_async(dispatch_get_main_queue(),
        ^{
             [__strongSelf.view makeToast:strMsg];
        });
        if(nStatus==200)
        {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC), dispatch_get_main_queue(),
            ^{
                [__strongSelf login_BackView];
            });
        }
    };
    [loginSer requestLogin:strUser password:strPwd];
}

-(void)login_BackView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCESS_VC object:nil];
    [self backRegSucc];
}


@end
