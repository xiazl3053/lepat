//
//  LeftViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "LeftViewController.h"
#import "HomeItemModel.h"
#import "Common.h"
#import "UserInfoViewController.h"
#import "LeftTableViewCell.h"
#import "LoginViewController.h"
#import "UserInfo.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_imgView;
}

@property (nonatomic,strong) NSMutableArray *itemList;
@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self initParams];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    self.itemList=[NSMutableArray array];
    
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"我的宠物";
    model.img=@"left_myfish";
    model.tag=10001;
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"微宠社区";
    model1.img=@"left_bbs";
    model1.tag=10002;
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"知识库";
    model2.img=@"left_knowledge";
    model2.tag=10003;
    
    HomeItemModel *model3=[[HomeItemModel alloc]init];
    model3.title=@"活动专区";
    model3.img=@"left_active";
    model3.tag=10004;
    
    HomeItemModel *model4=[[HomeItemModel alloc]init];
    model4.title=@"鱼友圈";
    model4.img=@"left_fishman";
    model4.tag=10005;
    
    HomeItemModel *model5=[[HomeItemModel alloc]init];
    model5.title=@"鱼友签到";
    model5.img=@"left_date";
    model5.tag=10006;
    
    HomeItemModel *model6=[[HomeItemModel alloc]init];
    model6.title=@"优惠券";
    model6.img=@"left_money";
    model6.tag=10007;
    
    [self.itemList addObject:model];
    [self.itemList addObject:model1];
    [self.itemList addObject:model2];
    [self.itemList addObject:model3];
    [self.itemList addObject:model4];
    [self.itemList addObject:model5];
    [self.itemList addObject:model6];
    
}

-(void)initViews{
    [self initBgView];
    [self initTableView];
    
}

-(void)initBgView{
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    bgView.image=[UIImage imageNamed:@"left_Bgview"];
    [self.view addSubview:bgView];
}

-(void)initTableView{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenSize.width, KMainScreenSize.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *my=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 260, 120)];
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake((200-60)*.5, 10, 60, 60)];
    icon.image=[UIImage imageNamed:@"left_icon_noraml"];
    [my addSubview:icon];
    _imgView=icon;
    
    [icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    
    UIButton *login=[[UIButton alloc]initWithFrame:CGRectMake((200-100)*.5, icon.bottom+15, 100, 25)];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:14];
    login.layer.borderColor=[UIColor whiteColor].CGColor;
    login.layer.borderWidth=.5;
    [login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [my addSubview:login];
    
    return my;
}

-(void)login:(UIButton *)aBtn{
    LoginViewController *login=[[LoginViewController alloc]init];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"CELL";
    LeftTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HomeItemModel *model=[self.itemList objectAtIndex:indexPath.row];
    [cell setValueWithHomeItemModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeItemModel *model=[self.itemList objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:KShowMainViewController object:model];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
