//
//  RecordModel.h
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) NSTimeInterval time;
@property (nonatomic,assign) NSInteger score;

@end
