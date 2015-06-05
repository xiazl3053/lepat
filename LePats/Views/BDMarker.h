//
//  BDMarker.h
//  LePats
//
//  Created by xiongchi on 15-6-3.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BMKPointAnnotation.h"
#import "NearInfo.h"

@interface BDMarker : BMKPointAnnotation

@property (nonatomic,assign) int nIndex;
@property (nonatomic,strong) NearInfo *near;

@end
