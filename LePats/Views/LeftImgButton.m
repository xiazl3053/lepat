//
//  LeftImgButton.m
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LeftImgButton.h"
#import "UIView+Add.h"

@implementation LeftImgButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(10, 5, 20, 20);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(35 , 0, 30, contentRect.size.height);
}

@end
