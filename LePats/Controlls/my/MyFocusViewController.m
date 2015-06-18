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
#import "Toast+UIView.h"
#import "FansModel.h"
#import "FriendCell.h"
#import "FocusService.h"
#import "TheyMainViewController.h"
#import "MJRefresh.h"

@interface MyFocusViewController ()<UITableViewDataSource,UITableViewDelegate,FriendViewDelegate>{
    NSArray *_focusList;
    MyFocusService *myFocusService;
    FocusService *focus;
}
@property (nonatomic,strong) UITableView *tableView;
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
    if (self.nUserId==[[UserInfo sharedUserInfo].strUserId intValue]) {
        self.title=@"我的关注";
    }else{
        self.title=@"TA的关注";
    }
}

-(void)initTableView{
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, [self barSize].height,KMainScreenSize.width,KMainScreenSize.height-[self barSize].height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    [self.view addSubview:self.tableView];
    
    
    __weak typeof(self) weakSelf = self;
    
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.legendHeader beginRefreshing];
    
    
    // 添加传统的上拉刷新
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)loadNewData{
    __weak typeof(self) weakSelf = self;
    myFocusService=[[MyFocusService alloc]init];
    myFocusService.focusServiceBlock=^(NSString *error,NSArray *data){
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        if (error) {
            [weakSelf.view makeToast:error];
        }else{
            _focusList=data;
            [weakSelf.tableView reloadData];
        }
    };
    [myFocusService requestUserId:self.nUserId];
    
}

-(void)loadMoreData{
    [self.tableView.footer endRefreshing];
    
}

-(void)initParams{
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _focusList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NearInfo *near = [_focusList objectAtIndex:indexPath.row];
    TheyMainViewController *theyView = [[TheyMainViewController alloc] initWithNear:near];
    [self.navigationController pushViewController:theyView animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"";
    FriendCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[FriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
