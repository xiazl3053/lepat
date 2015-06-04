//
//  MyFocusViewController.m
//  LePats
//
//  Created by admin on 15/6/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyFocusViewController.h"
#import "MyFocusService.h"
#import "UserInfo.h"

@interface MyFocusViewController ()

@end

@implementation MyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initParams{
    MyFocusService *service=[[MyFocusService alloc]init];
    int userID=[[UserInfo sharedUserInfo].strUserId intValue];
    [service requestUserId:userID];
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
