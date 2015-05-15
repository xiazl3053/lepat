//
//  BaseViewController.m
//  LePats
//
//  Created by admin on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    //隐藏标题栏
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
}

-(void)initNavigationBar{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    bgView.backgroundColor=[UIColor purpleColor];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [back setImage:[UIImage imageNamed:@"retrun"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(popviewcontroller) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:back];
    
    [self.view addSubview:bgView];
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
