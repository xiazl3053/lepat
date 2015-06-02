//
//  RegSettingViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RegSettingViewController.h"
#import "UIView+Extension.h"
#import "Toast+UIView.h"
#import "UpdUserService.h"
#import "UserInfo.h"


@interface RegSettingViewController()
{
    UITextField *txtNick;
    UITextField *txtPwd;
    UITextField *txtBirthday;
    UISegmentedControl *segSex;
    UpdUserService *updService;
}

@end

@implementation RegSettingViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息设置";
    [self createHeadView];
}

-(void)createHeadView
{
    txtNick = [[UITextField alloc] initWithFrame:Rect(10,60,self.view.width-20 ,40)];
                                                      
    txtPwd = [[UITextField alloc] initWithFrame:Rect(10,120,self.view.width-20 ,40)];
                                                     
    txtBirthday = [[UITextField alloc] initWithFrame:Rect(10,180,self.view.width-20 ,40)];
    
    [self.view addSubview:txtNick];
    [self.view addSubview:txtPwd];
    [self.view addSubview:txtBirthday];
    
    [self setTextStyle:[UIImage imageNamed:@"login_user_img"] txt:txtNick];
    
    [self setTextStyle:[UIImage imageNamed:@"login_pwd_img"] txt:txtPwd];
    
    [self setTextStyle:[UIImage imageNamed:@""] txt:txtBirthday];
    
    [txtNick setPlaceholder:@"请设置您的昵称"];
    [txtPwd setPlaceholder:@"请设置登录密码"];
    [txtBirthday setPlaceholder:@"出生日期(点击选择)"];
    
    segSex = [[UISegmentedControl alloc] initWithItems:[[NSArray alloc] initWithObjects:@"男",@"女", nil]];
    segSex.frame = Rect(self.view.width/2-80, 240, 160,40);
    [self.view addSubview:segSex];
    [segSex setSelectedSegmentIndex:0];
    
    UIButton *btnReg = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReg setTitle:@"注册" forState:UIControlStateNormal];
    [btnReg setBackgroundColor:RGB(15, 173, 225)];
    [btnReg setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btnReg addTarget:self action:@selector(regSettingUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    btnReg.frame = Rect(10, 300, self.view.width-20, 40);
}
-(void)regSettingUserInfo
{
    if (updService == nil)
    {
        updService = [[UpdUserService alloc] init];
    }
    NSString *strNick = txtNick.text;
    NSString *strPwd = txtPwd.text;
    NSString *strBirthday = txtBirthday.text;
    if ([strNick isEqualToString:@""]) {
        [self.view makeToast:@"昵称不能为空"];
        return ;
    }
    
    if ([strPwd isEqualToString:@""]) {
        [self.view makeToast:@"密码不能为空"];
        return ;
    }
    
    if ([strBirthday isEqualToString:@""]) {
        [self.view makeToast:@"生日必选"];
        return ;
    }
    
    int nSex;
    if([segSex selectedSegmentIndex]==0)
    {
        nSex = 1;
    }
    else
    {
        nSex = 2;
    }
    
    [UserInfo sharedUserInfo].strBirthday = strBirthday;
    [UserInfo sharedUserInfo].strNickName = strNick;
    [UserInfo sharedUserInfo].strPassword = strPwd;
    [UserInfo sharedUserInfo].nSex = nSex;
    
    __weak RegSettingViewController *__self = self;
    updService.httpBlock = ^(int nStatus)
    {
        NSString *strMsg = nil;
        switch (nStatus) {
            case 200:
            {
                strMsg = @"修改成功";
            }
                break;
            default:
            {
                strMsg = @"连接错误";
            }
            break;
        }
        __strong RegSettingViewController *__strongSelf = __self;
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [__strongSelf.view makeToast:strMsg];
        });
        if (nStatus==200)
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__strongSelf dismissViewControllerAnimated:NO completion:
                 ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_UPDATE_USER_VC object:nil];
                }];
            });
        }
    };
    [updService updReqUserInfo];
}

-(void)setTextStyle:(UIImage*)image txt:(UITextField *)txtInfo
{
    UIView *viewUser = [[UIView alloc] initWithFrame:Rect(0, 0, 32, 44)];
    UIImageView *imgUser = [[UIImageView alloc] initWithFrame:Rect(0, 10, 22, 22)];
    [imgUser setImage:image];
    [viewUser addSubview:imgUser];
    
    txtInfo.leftView = viewUser;
    txtInfo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtInfo.leftViewMode = UITextFieldViewModeAlways;
    txtInfo.keyboardType = UIKeyboardTypeDefault;
    
    [txtInfo.layer setMasksToBounds:YES];
    [txtInfo.layer setCornerRadius:3.0f];
    txtInfo.layer.borderWidth = 1.0f;
    [txtInfo setBackgroundColor:RGB(253, 252, 250)];
    txtInfo.layer.borderColor = RGB(237, 237, 237).CGColor;
}

@end
