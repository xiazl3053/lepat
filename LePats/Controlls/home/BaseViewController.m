//
//  BaseViewController.m
//  LePats
//
//  Created by admin on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Extension.h"

@interface BaseViewController ()
{
    UILabel *lblTitle;
}
@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    //隐藏标题栏
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
}

-(void)initNavigationBar
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    bgView.backgroundColor=RGB(253, 252, 250);
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [back setImage:[UIImage imageNamed:@"retrun"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(popviewcontroller) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:back];
    
    lblTitle = [[UILabel alloc] initWithFrame:Rect(50, 10,self.view.frame.size.width-100, 30)];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setFont:XCFONT(15)];
    [lblTitle setTextColor:RGB(145,143,144)];
    
    [bgView addSubview:lblTitle];
    
    
    UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0,43,self.view.width,0.5)];
    sLine1.backgroundColor = [UIColor colorWithRed:227/255.0
                                             green:227/255.0
                                              blue:227/255.0
                                             alpha:1.0];
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0,43.5,self.view.width, 0.5)] ;
    sLine2.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:sLine1];
    [bgView addSubview:sLine2];
    
    
    
    [self.view addSubview:bgView];
}

-(void)setTitle:(NSString *)title
{
    lblTitle.text = title;
}


-(void)popviewcontroller{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
