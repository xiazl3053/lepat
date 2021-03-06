//
//  HomeItemButton.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeItemButton.h"
#import "NSString+LineHeight.h"

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
    return CGRectMake((contentRect.size.width-image.size.width)*.5, 8, image.size.width, image.size.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateNormal];
    NSString *title=[self titleForState:UIControlStateNormal];
    CGSize size=[title boundingRectWithSize:CGSizeMake(280, 1000) withTextFont:[UIFont systemFontOfSize:12] withLineSpacing:5];
    //NSLog(@"NSStringFromCGSize=%@",NSStringFromCGSize(size));
    return CGRectMake((contentRect.size.width-size.width)*.5, image.size.height+10, 130, 20);
}


@end
