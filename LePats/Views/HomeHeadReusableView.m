//
//  HomeHeadReusableView.m
//  LePats
//
//  Created by admin on 15/5/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeHeadReusableView.h"
#import "HomeItemButton.m"
#import "HomeItemModel.h"

@implementation HomeHeadReusableView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    headView.image=[UIImage imageNamed:@"Tabbar_adView"];
    [self addSubview:headView];
    
    
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"每日签到";
    model.tag=101;
    model.img=@"home_sign";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"我要寻宝";
    model1.tag=102;
    model1.img=@"home_find";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"我要砸蛋";
    model2.tag=103;
    model2.img=@"home_egg";
    
    NSMutableArray *section=[NSMutableArray array];
    [section addObject:model];
    [section addObject:model1];
    [section addObject:model2];
    
    for (HomeItemModel *obj in section) {
        HomeItemButton *btn=[[HomeItemButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        
    }
}

@end
