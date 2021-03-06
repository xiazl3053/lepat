//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "WWSideslipViewController.h"
#import "Common.h"
#import "UserInfoViewController.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "MyPetsViewController.h"
#import "PetDetailViewController.h"
#import "HomeItemModel.h"


@interface WWSideslipViewController ()
{
    BOOL bLeft;
    NSInteger _index;
    UITapGestureRecognizer *rightTap;
    UIView *clearView;
}

@end

@implementation WWSideslipViewController
@synthesize speedf,sideslipTapGes;
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
    [self initParams];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:mainControl.view];
    
}

-(void)initParams{
    [self initRegisterNotification];
}

-(void)initRegisterNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoMyInfoViewCotroller:) name:KShowMainViewController object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showLeftViewFromSetting) name:KShowLeftViewController object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gotoViewController) name:KGotoViewController object:nil];
}

-(void)gotoViewController{
    MainViewController *tabbar=(MainViewController*)mainControl;
    [tabbar setSelectedIndex:4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
                        andBackgroundImage:(UIImage *)image;
{
    if(self){
        speedf = 0.5;
        
        leftControl = LeftView;
        mainControl = MainView;
        righControl = RighView;
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        //滑动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [mainControl.view addGestureRecognizer:pan];
        
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [sideslipTapGes setNumberOfTapsRequired:1];
        
       // [mainControl.view addGestureRecognizer:sideslipTapGes];
        
        leftControl.view.hidden = YES;
        righControl.view.hidden = YES;
        
        [self.view addSubview:leftControl.view];
        [self.view addSubview:righControl.view];
        
        [self.view addSubview:mainControl.view];
        
        clearView = [[UIView alloc] initWithFrame:mainControl.view.bounds];
        [clearView setBackgroundColor:[UIColor clearColor]];
        
        
        rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainView)];
        rightTap.numberOfTapsRequired = 1;
//        [mainControl.view addGestureRecognizer:rightTap];
    }
    return self;
}
//
//-(void)showMainViewController
//{
//    
//}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec
{
    MainViewController *tabbar=(MainViewController*)mainControl;
    UINavigationController *nav=(UINavigationController *)tabbar.selectedViewController;
    if (![nav.topViewController isKindOfClass:[HomeViewController class]])
    {
        return ;
    }
    
    CGPoint point = [rec translationInView:self.view];
    scalef = (point.x*speedf+scalef);
    //根据视图位置判断是左滑还是右边滑动
    if (rec.view.frame.origin.x>=0)
    {
        leftControl.view.hidden = NO;
    }
    else
    {
        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+scalef/1000,1+scalef/1000);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        righControl.view.hidden = NO;
        leftControl.view.hidden = YES;
    }
    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded)
    {
        if (scalef>140*speedf)
        {
            [self showLeftView];
        }
        else
        {
            [self showMainView];
            scalef = 0;
        }
    }
}

#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
        scalef = 0;

    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    [clearView removeFromSuperview];
    [mainControl.view removeGestureRecognizer:rightTap];
}

-(void)gotoMyInfoViewCotroller:(NSNotification *)notification
{
    NSLog(@"notification.object=%@",notification.object);
    [self showMainView];
    HomeItemModel *model=notification.object;
    [self gotoInfoViewWithTag:model.tag];
}

-(void)gotoInfoViewWithTag:(NSInteger)tag{
    MainViewController *tabbar=(MainViewController*)mainControl;
    UIViewController *vc=tabbar.selectedViewController;
    
    switch (tag)
    {
        case 10001:
        {
            MyPetsViewController *myPets=[[MyPetsViewController alloc]init];
            myPets.hidesBottomBarWhenPushed=YES;
            [((UINavigationController*)vc) pushViewController:myPets animated:YES];
            
        }break;
        case 10002:
        {
            PetDetailViewController *addPet=[[PetDetailViewController alloc]init];
            addPet.hidesBottomBarWhenPushed=YES;
            [((UINavigationController*)vc) pushViewController:addPet animated:YES];
        
        }break;
        default:
        {
            
        }
        break;
    }
}
//显示左视图
-(void)showLeftView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width*1.2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    [mainControl.view addSubview:clearView];
    [mainControl.view addGestureRecognizer:rightTap];
}

-(void)showLeftViewFromSetting
{
    leftControl.view.hidden = NO;
    if (_index%2==0)
    {
        [self showLeftView];
    }else{
        [self showMainView];
    }
    _index++;
}

//显示右视图
-(void)showRighView
{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

- (BOOL)prefersStatusBarHidden
{
    return NO; //返回NO表示要显示，返回YES将hiden
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KGotoViewController object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KShowMainViewController object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:KShowLeftViewController object:nil];
}

@end
