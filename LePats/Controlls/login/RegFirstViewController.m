//
//  RegFirstViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-18.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RegFirstViewController.h"
#import "UIView+Extension.h"
#import "RegSecondVIewController.h"

#import "ProgressHUD.h"
#import "Toast+UIView.h"
#import "RegisterService.h"

@interface RegFirstViewController()
{
    UITextField *txtAddress;
    UITextField *txtNumber;
    RegisterService *regServer;
}
@end


@implementation RegFirstViewController

-(id)init
{
    self = [super init];
    return self;
}

-(void)loadView
{
    [super loadView];
}

-(void)authMobile
{
    [txtNumber resignFirstResponder];
    [txtAddress resignFirstResponder];
    if([txtNumber.text isEqualToString:@""])
    {
        [self.view makeToast:@"手机号码不能为空"];
        return ;
    }
    [ProgressHUD show:@"请求发送验证码"];
    if (regServer==nil) {
        regServer = [[RegisterService alloc] init];
    }
    __weak RegFirstViewController *__self = self;
    regServer.httpCode = ^(int nStatus,NSString *strCode)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        switch (nStatus) {
            case 200:
            {
                RegSecondViewController *regSecond = [[RegSecondViewController alloc] init];
                [__self presentViewController:regSecond animated:YES completion:nil];
            }
            break;
            case 50001:
            {
                [__self.view makeToast:@"已经注册"];
            }
            break;
            default:
            {
                
            }
            break;
        }
    };
    [regServer requestRegCode:[txtNumber text]];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";
    UILabel *lblContent = [[UILabel alloc] initWithFrame:Rect(30, 60,self.view.width-60, 15)];
    [lblContent setTextColor:RGB(101, 101, 101)];
    [lblContent setText:@"请确保您的手机畅通,用于接受验证码短信"];
    [lblContent setFont:XCFONT(12)];
    
    [self.view addSubview:lblContent];
    txtAddress =[[UITextField alloc] initWithFrame:Rect(10,lblContent.y+lblContent.height+15, self.view.width-20, 44)];
    [txtAddress setText:@"中国"];
    [txtAddress setBackgroundColor:RGB(253, 251, 251)];
    
    UIView *viewAddr = [[UIView alloc] initWithFrame:Rect(0, 0, 20, 20)];
    txtAddress.leftView = viewAddr;
    txtAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtAddress.leftViewMode = UITextFieldViewModeAlways;
    txtAddress.keyboardType = UIKeyboardTypePhonePad;
    [txtAddress setBorderStyle:UITextBorderStyleNone];
 
    txtNumber = [[UITextField alloc] initWithFrame:Rect(10,txtAddress.y+txtAddress.height+13,self.view.width-20, 44)];
    [txtNumber setPlaceholder:@"请输入您的手机号码"];
    [txtNumber setBackgroundColor:RGB(253, 251, 251)];
    [txtNumber setBorderStyle:UITextBorderStyleNone];
   
    UIView *viewNumber = [[UIView alloc] initWithFrame:Rect(0, 0, 20, 20)];
    txtNumber.leftView = viewNumber;
    txtNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtNumber.leftViewMode = UITextFieldViewModeAlways;
    txtNumber.keyboardType = UIKeyboardTypePhonePad;
    [txtNumber setBorderStyle:UITextBorderStyleNone];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regOKBack) name:MESSAGE_UPDATE_USER_T_VC object:nil];
    
    [self.view addSubview:txtAddress];
    [self.view addSubview:txtNumber];
   
    
    //UITextField layer 设置
    txtNumber.layer.borderWidth = 1;
    [txtNumber.layer setMasksToBounds:YES];
    txtNumber.layer.cornerRadius = 3.0f;
    txtNumber.layer.borderColor = RGB(227, 227, 227).CGColor;
    
    txtAddress.layer.borderWidth = 1;
    [txtAddress.layer setMasksToBounds:YES];
    txtAddress.layer.cornerRadius = 3.0f;
    txtAddress.layer.borderColor = RGB(227, 227, 227).CGColor;
    
    UIButton *btnAuth = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAuth addTarget:self action:@selector(authMobile) forControlEvents:UIControlEventTouchUpInside];
    [btnAuth setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    [btnAuth setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btnAuth setBackgroundColor:RGB(0, 146, 255)];
    btnAuth.titleLabel.font = XCFONT(17);
    [btnAuth.layer setMasksToBounds:YES];
    btnAuth.layer.cornerRadius = 3.0f;
    
    btnAuth.frame = Rect(10,txtNumber.y+txtNumber.height+18,self.view.width-20,40);
    [self.view addSubview:btnAuth];
}

-(void)regOKBack
{
    [self.navigationController popViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_UPDATE_USER_TH_VC object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
