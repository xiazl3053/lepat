//
//  TwoTitleButton.m
//  LePats
//
//  Created by admin on 15/6/16.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TwoTitleButton.h"

@implementation TwoTitleButton

-(id)initWithFrame:(CGRect)frame title1:(NSString *)title1 title2:(NSString *)title2
{
    if (self=[super initWithFrame:frame]) {
        [self initViewsWithTitle1:title1 title2:title2];
    }
    return self;
}

-(void)initViewsWithTitle1:(NSString *)title1 title2:(NSString *)title2{
    
    UILabel *number=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width*.5, self.height)];
    number.textAlignment=NSTextAlignmentRight;
    number.textColor=[UIColor whiteColor];
    number.font=[UIFont systemFontOfSize:12];
    number.text=title1;
    [self addSubview:number];
    
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(number.right, 0, self.width*.5, self.height)];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:12];
    title.text=title2;
    [self addSubview:title];


}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
