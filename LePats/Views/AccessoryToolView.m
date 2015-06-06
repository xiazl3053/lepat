//
//  AccosoryToolView.m
//  LePats
//
//  Created by admin on 15/6/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AccessoryToolView.h"

@implementation AccessoryToolView



-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
       // [self initViews];
    }
    return self;
}


-(id)init{
    
    if (self=[super initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 44)]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    
    self.backgroundColor=[UIColor grayColor];
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font=[UIFont systemFontOfSize:14];
    cancel.tag=1;
    [cancel addTarget:self action:@selector(clickIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    
    
    UIButton *done=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width-60, 0, 60, 44)];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    done.titleLabel.font=[UIFont systemFontOfSize:14];
    done.tag=2;
    [done addTarget:self action:@selector(clickIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:done];
}

-(void)clickIndex:(UIButton *)aBtn{
    NSLog(@"%@",self.accessoryToolViewClickBlock);
    if (self.accessoryToolViewClickBlock) {
        self.accessoryToolViewClickBlock(aBtn.tag);
    }
}


@end
