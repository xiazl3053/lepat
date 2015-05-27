//
//  UploadService.h
//  LePats
//
//  Created by xiongchi on 15-5-26.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

@interface UploadService : HttpManager

-(void)requestUploadLocation:(CGFloat)fLat lng:(CGFloat)fLng;


@end
