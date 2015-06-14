//
//  RelationService.h
//  LePats
//
//  Created by admin on 15/6/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^RelatonBlock)(NSString *error,NSInteger code);
@interface RelationService : HttpManager
-(void)requestOperId:(NSString *)strUserId;
@property (nonatomic,copy) RelatonBlock relationBlock;
@end
