//
//  PetsButton.m
//  LePats
//
//  Created by xiongchi on 15-6-10.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetsButton.h"

@implementation PetsButton


-(id)initWithTitle:(NSString *)strTitle nor:(NSString *)strNor high:(NSString *)strHigh frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setTitle:strTitle forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:strNor] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:strHigh] forState:UIControlStateHighlighted];
    self.titleLabel.font = XCFONT(12);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return Rect(0, 45, contentRect.size.width, 14);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return Rect(7.5, 5, 30, 30);
}
@end
