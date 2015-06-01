//
//  SexButton.m
//  LePats
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "SexButton.h"

@implementation SexButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    UIImage *image=[self imageForState:UIControlStateSelected];
    NSLog(@"NSStringFromCGSize(image.size)=%@",NSStringFromCGSize(image.size));
    return CGRectMake(self.frame.size.width-image.size.width-10,(self.frame.size.height-image.size.height)*.5 , image.size.width, image.size.height);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(10 , 0, self.frame.size.width-50, self.frame.size.height);
}

@end
