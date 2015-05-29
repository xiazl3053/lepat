//
//  FrindListViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FriendListViewController.h"
#import "UIView+Extension.h"
#import "FindService.h"

@interface FriendListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *aryData;
    FindService *findSer;
}


@property (nonatomic,strong) UITableView *tableView;

@end

@implementation FriendListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近鱼友列表";
    [self setRightHidden:NO];
    [self setRightTitle:@"地图"];
    __weak FriendListViewController *__self = self;
    findSer = [[FindService alloc] init];
    
    [self addRightEvent:^(id sender)
    {
        [__self comeToMap];
    }];
    [self initView];
}

-(void)comeToMap
{
    
}

-(void)findData
{
    
    
    
    
    
    [findSer requestFindNear:0 lng:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:Rect(0, 88, self.view.width,self.view.height-88)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [aryData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell
    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
