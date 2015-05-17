//
//  AppDelegate.h
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapView.h"
#import "BMapKit.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager *bmkManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

