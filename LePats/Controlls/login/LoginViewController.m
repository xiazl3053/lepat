//
//  LoginViewController.m
//  LePats
//
//  Created by admin on 15/5/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "LogView.h"
#import "Toast+UIView.h"
#import "LoginService.h"
#import "UIView+Extension.h"
#import "RegFirstViewController.h"

@interface LoginViewController()
{
    LogView *loginView;
    LoginService *loginSer;
}
@end


@implementation LoginViewController

-(id)init
{
    self = [super init];
    
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:RGB(250, 250, 250)];
    loginView = [[LogView alloc] initWithFrame:Rect(10, 120,self.view.frame.size.width-20, 100)];
    [self.view addSubview:loginView];

    self.title = @"登录";
    [self setRightHidden:NO];
    [self setRightTitle:@"注册"];
    __weak LoginViewController *__self = self;
    [self addRightEvent:^(id sender){
        RegFirstViewController *regFirst = [[RegFirstViewController alloc] init];
        [__self.navigationController pushViewController:regFirst animated:YES];
    }];
    UILabel *lblName = [[UILabel alloc] initWithFrame:Rect(50, 64, kScreenSourchWidth-100, 20)];
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
    btnLogin.titleLabel.font = XCFONT(17);
    [self.view addSubview:btnLogin];
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
    __weak LoginViewController *__self = self;
    loginSer.httpBlock = ^(int nStatus)
    {
        switch (nStatus) {
            case 200:
            {
                DLog(@"登录成功");
                [__self.view makeToast:@"登录成功"];
            }
            break;
            case 50001:
            {
                DLog(@"登录失败，用户名或者密码错误");
            }
            break;
            default:
            {
                DLog(@"连接服务器错误");
            }
            break;
        }
    };
    [loginSer requestLogin:strUser password:strPwd];
}

@end
