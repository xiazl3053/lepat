//
//  TUserService.h
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"
@class NearInfo;

typedef void(^HttpTBlock)(int nStatus,NearInfo *aryItem);

@interface TUserService : HttpManager

@property (nonatomic,copy) HttpTBlock httpBlock;

-(void)requestOperId:(NSString *)strUserId;



@end
