//
//  MyFansViewController.m
//  LePats
//
//  Created by admin on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyFansViewController.h"
#import "MyFansService.h"
#import "UserInfo.h"

@interface MyFansViewController (){
    
}

@end

@implementation MyFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initSelfView];
    // Do any additional setup after loading the view.
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
}

-(void)initSelfView{
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initTableView{
//    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, [self barSize].height,KMainScreenSize.width,KMainScreenSize.height-[self barSize].height)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    //_nTimeOut = 0;
//    
//    //[tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.view addSubview:tableView];
}

-(void)initParams{
    MyFansService *service=[[MyFansService alloc]init];
    int userID=[[UserInfo sharedUserInfo].strUserId intValue];
    [service requestUserId:userID];
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
