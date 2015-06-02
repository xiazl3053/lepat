//
//  MainViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MainViewController.h"
#import "UserInfoViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self createrView];
        //[self initViews];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initViews{
   // [self initVC];
}

-(void)initVC{
    //b.创建子控制器
    UIViewController *c1=[[UIViewController alloc]init];
    c1.view.backgroundColor=[UIColor grayColor];
    [self addNavigationWithViewController:c1 tabBarTitle:@"消息" tabBarImage:@"" tabBarTag:100];
    
    UIViewController *c2=[[UIViewController alloc]init];
    c2.view.backgroundColor=[UIColor brownColor];
    [self addNavigationWithViewController:c2 tabBarTitle:@"联系人" tabBarImage:@"" tabBarTag:200];
    
    UIViewController *c3=[[UIViewController alloc]init];
    c3.view.backgroundColor=[UIColor greenColor];
    [self addNavigationWithViewController:c3 tabBarTitle:@"动态" tabBarImage:@"" tabBarTag:200];
  
    UserInfoViewController *c4=[[UserInfoViewController alloc]init];
    [self addNavigationWithViewController:c4 tabBarTitle:@"我的" tabBarImage:@"" tabBarTag:100];
    
    //c.添加子控制器到ITabBarController中
    //c.1第一种方式
//    [self addChildViewController:c1];
//    [self addChildViewController:c2];
//    [self addChildViewController:c3];
  
    //c.2第二种方式
    //self.viewControllers=@[c1,c2,c3,nav];
    
}

-(void)addNavigationWithViewController:(UIViewController *)vc tabBarTitle:(NSString *)title tabBarImage:(NSString *)image tabBarTag:(NSInteger)tag{

    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
    UITabBarItem *tabBar = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:@""] tag:tag];
    nav.tabBarItem = tabBar;
    [self addChildViewController:nav];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createrView
{
    UIImageView * imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IMG_0233.png"]];
    [imgView setFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:imgView];
}

@end
