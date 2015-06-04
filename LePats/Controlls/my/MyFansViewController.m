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
#import "Toast+UIView.h"

@interface MyFansViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    
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
    self.title=@"我的粉丝";
}

-(void)initTableView{
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, [self barSize].height,KMainScreenSize.width,KMainScreenSize.height-[self barSize].height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_nTimeOut = 0;
    
    //[tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.view addSubview:tableView];
    _tableView=tableView;
}

-(void)initParams{
    MyFansService *service=[[MyFansService alloc]init];
    int userID=[[UserInfo sharedUserInfo].strUserId intValue];
    service.myFansServiceBlock=^(NSString *error,NSArray *data){
        if (error) {
            [self.view makeToast:error];
        }else{
            [_tableView reloadData];
        }
    };
    [service requestUserId:userID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
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
