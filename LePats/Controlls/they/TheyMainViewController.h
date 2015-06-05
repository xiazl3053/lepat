//
//  TheyMainViewController.h
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"
@class NearInfo;

@interface TheyMainViewController : BaseViewController

@property (nonatomic,strong) NSString *strUserId;

-(id)initWithNear:(NearInfo*)near;

@end
