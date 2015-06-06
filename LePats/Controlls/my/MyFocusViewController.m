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
#import "MJRefresh.h"
#import "Toast+UIView.h"
#import "FansModel.h"
#import "FriendCell.h"
#import "FocusService.h"
#import "TheyMainViewController.h"

@interface MyFocusViewController ()<UITableViewDataSource,UITableViewDelegate,FriendViewDelegate>{

    UITableView *_tableView;
    NSArray *_focusList;
    FocusService *focus;
}

@end

@implementation MyFocusViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initParams];
    // Do any additional setup after loading the view.
}



-(void)initViews{
    [self initSelfView];
    [self initTableView];
}

-(void)initSelfView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我的关注";
}

-(void)initTableView{
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, [self barSize].height,KMainScreenSize.width,KMainScreenSize.height-[self barSize].height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //_nTimeOut = 0;
    
    [tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [tableView addFooterWithTarget:self action:@selector(footerrefeshing)];
    [self.view addSubview:tableView];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    _tableView=tableView;
}

-(void)headerRereshing{
    
}

-(void)footerrefeshing{
    
}

-(void)initParams{
    MyFocusService *service=[[MyFocusService alloc]init];
    int userID=[[UserInfo sharedUserInfo].strUserId intValue];
    service.focusServiceBlock=^(NSString *error,NSArray *data){
        if (error) {
            [self.view makeToast:error];
        }else{
            _focusList=data;
            [_tableView reloadData];
        }
    };
    [service requestUserId:userID];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _focusList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"";
    FriendCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    NearInfo *model=[_focusList objectAtIndex:indexPath.row];
    cell.delegate=self;
    [cell setNearInfo:model];
    return cell;
}


-(void)friendView:(FriendCell *)friend focus:(NSString *)strUserId
{
    if(focus==nil)
    {
        focus = [[FocusService alloc] init];
    }
    __weak MyFocusViewController *__self = self;
    __weak FriendCell *__friend = friend;
    focus.httpFocus = ^(int nStatus,NSString *strMsg)
    {
        if (nStatus == 1)
        {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [__friend setAttenBtnSwtich];
                           });
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               [__self.view makeToast:strMsg duration:1.5 position:@"center"];
                           });
        }
    };
    [focus requestFocus:strUserId];
}

-(void)friendView:(FriendCell *)friend index:(int)nIndex
{
    if (nIndex>=0)
    {
        NearInfo *near = [_focusList objectAtIndex:nIndex];
        TheyMainViewController *theyView = [[TheyMainViewController alloc] initWithNear:near];
        [self.navigationController pushViewController:theyView animated:YES];
    }
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
