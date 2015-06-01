//
//  HomeGiftItemButton.m
//  LePats
//
//  Created by admin on 15/5/31.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeGiftItemButton.h"
#import "NSString+LineHeight.h"

@implementation HomeGiftItemButton

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateNormal];
    NSLog(@"NSStringFromCGSize(image.size)=%@",NSStringFromCGSize(image.size));
    return CGRectMake((contentRect.size.width-image.size.width)*.5, 5, image.size.width, image.size.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateNormal];
    NSString *title=[self titleForState:UIControlStateNormal];
    CGSize size=[title boundingRectWithSize:CGSizeMake(280, 1000) withTextFont:[UIFont systemFontOfSize:12] withLineSpacing:5];
    NSLog(@"NSStringFromCGSize=%@",NSStringFromCGSize(size));
    return CGRectMake((contentRect.size.width-size.width)*.5 , image.size.height, self.frame.size.width, 20);
}

@end
