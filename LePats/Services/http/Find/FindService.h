//
//  FindService.h
//  LePats
//
//  Created by xiongchi on 15-5-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpRequestNear)(int nStatus);



@interface FindService : HttpManager

-(void)requestFindNear:(CGFloat)fLat lng:(CGFloat)fLng;

@end
