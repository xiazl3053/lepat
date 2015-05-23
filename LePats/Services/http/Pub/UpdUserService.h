//
//  UpdUserService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpUpdUser)(int nStatus);


@interface UpdUserService : HttpManager

@property (nonatomic,copy ) HttpUpdUser httpBlock;


-(void)updReqUserInfo;

@end
