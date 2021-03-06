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
#import "MyInfoService.h"
#import "Toast+UIView.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_imgView;
    UIButton *_login;
    UITableView *tableView;
    UILabel *_nickName;
    MyInfoService *infoService;
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
    [self initRegitster];
    [self initViews];
    
    
    // Do any additional setup after loading the view.
}

-(void)initRegitster
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginInfo) name:LOGIN_SUCESS_VC object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLogout) name:KUserLogout object:nil];
}

-(void)userLogout
{
    _login.hidden=NO;
    _imgView.image=[UIImage imageNamed:@"left_icon_noraml"];
    _nickName.hidden=YES;
}

-(void)getLoginInfo
{
    if (infoService==nil) {
      infoService=[[MyInfoService alloc]init];
    }
    __weak UIImageView *__imgView = _imgView;
    __weak UIButton *__login = _login;
    __weak UILabel *__nickName = _nickName;
    __weak UITableView *__tableView = tableView;
    infoService.getMyInfoBlock=^(NSString *error)
    {
        if (!error)
        {
            DLog("路径:%@",[UserInfo sharedUserInfo].strUserIcon);
            dispatch_async(dispatch_get_main_queue(),
            ^{
                [__tableView reloadData];
                [__imgView sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
                __nickName.text=[UserInfo sharedUserInfo].strNickName;
                if ([UserInfo sharedUserInfo].strToken)
                {
                    __login.hidden=YES;
                    __nickName.hidden=NO;
                }
            });
            
        }
        else
        {
            
        }
    };
    [infoService requestUserId:0];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    [self getLoginInfo];
}


-(void)getPersonInfo
{
    infoService=[[MyInfoService alloc]init];
    infoService.getMyInfoBlock=^(NSString *error){
        if (!error)
        {
            [_imgView sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
            _nickName.text=[UserInfo sharedUserInfo].strNickName;
            if ([UserInfo sharedUserInfo].strToken)
            {
                _login.hidden=YES;
                _nickName.hidden=NO;
            }

        }else{
        
        }
    };
    [infoService requestUserId:0];
}

-(void)initParams{
    [self initRegitster];
    
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

-(void)initViews
{
    [self initBgView];
    [self initTableView];
    
}

-(void)initBgView{
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    bgView.image=[UIImage imageNamed:@"left_Bgview"];
    [self.view addSubview:bgView];
}

-(void)initTableView
{
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, KMainScreenSize.width, KMainScreenSize.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor clearColor];
    tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *my=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 260, 120)];
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake((200-60)*.5, 10, 60, 60)];
    icon.image=[UIImage imageNamed:@"left_icon_noraml"];
    icon.layer.cornerRadius=icon.frame.size.width*.5;
    icon.layer.masksToBounds=YES;
    [my addSubview:icon];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMyView)];
    [icon addGestureRecognizer:tap];
    icon.userInteractionEnabled=YES;
    
    _imgView=icon;
    DLog(@"UserInfo sharedUserInfo].strUserIcon:%@",[UserInfo sharedUserInfo].strUserIcon);
    [icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    
    UIButton *login=[[UIButton alloc]initWithFrame:CGRectMake((200-100)*.5, icon.bottom+15, 100, 25)];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:14];
    login.layer.borderColor=[UIColor whiteColor].CGColor;
    login.layer.borderWidth=1;
    [login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    _login=login;
    [my addSubview:login];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake((200-100)*.5, icon.bottom+5, 100, 25)];
    if ([UserInfo sharedUserInfo].strMobile)
    {
        login.hidden=YES;
        title.text=[UserInfo sharedUserInfo].strNickName;
    }else{
        title.hidden=YES;
        login.hidden=NO;
    }
    _nickName=title;
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    [my addSubview:title];
    
    return my;
}

-(void)gotoMyView{
    if ([UserInfo sharedUserInfo].strToken) {
         [[NSNotificationCenter defaultCenter]postNotificationName:KShowMainViewController object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:KGotoViewController object:nil];
    }
}

-(void)login:(UIButton *)aBtn
{
   LoginViewController *login=[[LoginViewController alloc]init];
   [self presentViewController:login animated:YES completion:nil];
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
    if ([UserInfo sharedUserInfo].strMobile) {
        HomeItemModel *model=[self.itemList objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:KShowMainViewController object:model];
    }else{
        [self.view makeToast:@"尚未登陆"];
        [self login:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
