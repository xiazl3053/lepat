//
//  HomeItemButton.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeItemButton.h"

@implementation HomeItemButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateNormal];
    return CGRectMake((contentRect.size.width-image.size.width*2)*.5, 15, image.size.width*2, image.size.height*2);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateNormal];
    return CGRectMake(45, image.size.height*2+25, 130, 20);
}


@end
