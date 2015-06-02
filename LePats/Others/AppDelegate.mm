//
//  AppDelegate.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "WWSideslipViewController.h"
#import "FindService.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "LoginService.h"
#import "UserInfo.h"
#import "RegisterService.h"
#import "UpdUserService.h"
#import "MyPetService.h"
#import "PetSortService.h"
#import "HttpUploadManager.h"
#import "UploadService.h"
#import "UserInfo.h"
#import "LoginViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>{
    WWSideslipViewController *_slide;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *main = [story instantiateViewControllerWithIdentifier:@"MainViewController"];
    main.delegate=self;
    RightViewController *right = [story instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    LeftViewController *left = [story instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    WWSideslipViewController * slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:main andRightView:right andBackgroundImage:[UIImage imageNamed:@"bg.png"]];
    
    _slide=slide;
    //滑动速度系数
    [slide setSpeedf:0.5];
    
    //点击视图是是否恢复位置
    slide.sideslipTapGes.enabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestInfo) name:MESSAGE_LOGIN_SUC_VC object:nil];
    
    bmkManager = [[BMKMapManager alloc] init];
    BOOL ret = [bmkManager start:@"ibGcUE1K7Vg7QksSjpxLRprl" generalDelegate:self];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
    
    LoginService *login = [[LoginService alloc] init];
    //[login requestLogin:@"13888888888" password:@"123456"];
    
    [self.window setRootViewController:slide];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"%s",__FUNCTION__);
    if ([UserInfo sharedUserInfo].strToken) {
        return YES;
    }else{
        
        
        LoginViewController *login=[[LoginViewController alloc]init];
        [_slide presentViewController:login animated:YES completion:^{
            
        }];
        return NO;
    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%s",__FUNCTION__);
}
/*
 lat = "23.108941";
 lng = "113.455208";
 */
/*
 lat = "23.108935";
 lng = "113.455254";
 */

-(void)requestInfo
{
//    MyPetService *myPet = [[MyPetService alloc] init];
//    [myPet requestPetInfo:1];
//
//    HttpUploadManager *httpUpload = [[HttpUploadManager alloc] init];
//    [httpUpload uploadPerson:[UIImage imageNamed:@"my"]];
//    UploadService *upload = [[UploadService alloc] init];
//    [upload requestUploadLocation:113.2759952545136 lng:23.117055306224895];
    //113.275991
    
//    FindService *findService = [[FindService alloc] init];
//    [findService requestFindNear:113.2759952545136 lng:23.117055306224895];
//    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        DLog(@"联网成功");
    }
    else{
        DLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError)
    {
        DLog(@"授权成功");
    }
    else {
        DLog(@"onGetPermissionState %d",iError);
    }
}


@end
