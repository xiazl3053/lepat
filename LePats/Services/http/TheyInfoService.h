//
//  TheyInfoService.h
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpTheyBlock)(int nStatus,NSArray *aryItem);


@interface TheyInfoService : HttpManager

@property (nonatomic,copy) HttpTheyBlock httpBlock;

-(void)requestUserId:(NSString *)strUserId;




@end
