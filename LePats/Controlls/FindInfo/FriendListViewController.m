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
#import "FriendCell.h"
#import "NearInfo.h"

@interface FriendListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    FindService *findSer;
}


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *aryNear;
@end

@implementation FriendListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"附近鱼友列表";
    [self setRightHidden:NO];
//    [self setRightTitle:@"地图"];
    [self setRightRect:Rect(self.view.width-50,2, 36, 36)];
    [self setRightImg:@"position" high:nil select:nil];
    
    __weak FriendListViewController *__self = self;
    findSer = [[FindService alloc] init];
    _aryNear = [NSMutableArray array];
    [self addRightEvent:^(id sender)
    {
        [__self comeToMap];
    }];
    [self initView];
    [self findData];
}

-(void)comeToMap
{
    
}

-(void)findData
{
    __weak FriendListViewController *__self =self;
    findSer.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
        DLog(@"aryData_length:%lu",aryInfo.count);
        [__self.aryNear removeAllObjects];
        [__self.aryNear addObjectsFromArray:aryInfo];
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [__self.tableView reloadData];
        });
    };
    //纬度＋经度
    [findSer requestFindNear:23.1170550 lng:113.275999];
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
    if(!_aryNear)
    {
        return 0;
    }
    return [_aryNear count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strFriendIdentifier = @"friendCellIdentifier";
//    UITableViewCell
    FriendCell *friend = [tableView dequeueReusableCellWithIdentifier:strFriendIdentifier];
    if (friend==nil)
    {
        friend = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strFriendIdentifier];
        NearInfo *near = [_aryNear objectAtIndex:indexPath.row];
        [friend setNearInfo:near];
        UIView *bkView = [[UIView alloc] init];
        [bkView setBackgroundColor:[UIColor whiteColor]];
        [friend setSelectedBackgroundView:bkView];
    }
    
    return friend;
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
