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

@interface MyFocusViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tableView;
    NSArray *_focusList;
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    
    FansModel *model=[_focusList objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    cell.textLabel.text=model.strName;
    cell.detailTextLabel.text=model.strSignature;
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
