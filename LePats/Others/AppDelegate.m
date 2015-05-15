//
//  AppDelegate.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "WWSideslipViewController.h"
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

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *main = [story instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    RightViewController *right = [story instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    LeftViewController *left = [story instantiateViewControllerWithIdentifier:@"LeftViewController"];
    
    WWSideslipViewController * slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:main andRightView:right andBackgroundImage:[UIImage imageNamed:@"bg.png"]];
    
    //滑动速度系数
    [slide setSpeedf:0.5];
    
    //点击视图是是否恢复位置
    slide.sideslipTapGes.enabled = YES;
    
    //    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:slide];
    
    [self.window setRootViewController:slide];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)requestInfo
{
    MyPetService *myPet = [[MyPetService alloc] init];
    [myPet requestPetInfo:1];
    
    HttpUploadManager *httpUpload = [[HttpUploadManager alloc] init];
    [httpUpload uploadPerson:[UIImage imageNamed:@"my"]];
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

@end
