//
//  HomeHeadReusableView.m
//  LePats
//
//  Created by admin on 15/5/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeHeadReusableView.h"
#import "HomeItemButton.h"
#import "HomeItemModel.h"
#import "HomeHeadItemButton.h"
#import "HomeGiftItemButton.h"

@interface HomeHeadReusableView (){
    UIView *_topView;
    UIView *_centerView;
    UIView *_bottomView;

}

@end

@implementation HomeHeadReusableView

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    [self initSelfView];
    [self initTopView];
    [self initCenterView];
    [self initBottomView];
    
}

-(void)initSelfView{
    UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    headView.image=[UIImage imageNamed:@"Tabbar_adView"];
    [self addSubview:headView];
    
}

-(void)initTopView{
    
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
    topView.backgroundColor=[UIColor clearColor];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.frame.size.width, 30)];
    title.text=@"我的积分";
    title.font=[UIFont systemFontOfSize:30];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    [topView addSubview:title];
    
    UILabel *score=[[UILabel alloc]initWithFrame:CGRectMake(0, title.bottom+10, self.frame.size.width, 30)];
    score.text=@"150";
    score.font=[UIFont systemFontOfSize:30];
    score.textAlignment=NSTextAlignmentCenter;
    score.textColor=[UIColor whiteColor];
    [topView addSubview:score];
    
    [self addSubview:topView];
    _topView=topView;
}

-(void)initCenterView{
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"每日签到";
    model.tag=101;
    model.img=@"home_center_sign";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"我要寻宝";
    model1.tag=102;
    model1.img=@"home_center_seach";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"我要砸蛋";
    model2.tag=103;
    model2.img=@"home_center_egg";
    
    NSMutableArray *section=[NSMutableArray array];
    [section addObject:model];
    [section addObject:model1];
    [section addObject:model2];
    
    UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom, self.frame.size.width, 200*.5)];
    centerView.backgroundColor=[UIColor clearColor];
    
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200*.5)];
    bgView.backgroundColor=UIColorFromRGB(0x000000);
    bgView.alpha=0.05;
    
    [centerView addSubview:bgView];
    
    for (int i=0; i<section.count; i++) {
        HomeItemModel *obj=[section objectAtIndex:i];
        HomeHeadItemButton *btn=[[HomeHeadItemButton alloc]initWithFrame:CGRectMake(i*KMainScreenSize.width/3.0, 0, KMainScreenSize.width/3.0, 200*.5)];
        [btn setImage:[UIImage imageNamed:obj.img] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitle:obj.title forState:UIControlStateNormal];
        [centerView addSubview:btn];
    }
    [self addSubview:centerView];
    _centerView=centerView;
}

-(void)initBottomView{
    
    HomeItemModel *model4 = [[HomeItemModel alloc] init];
    model4.title = @"大礼包";
    model4.tag = 105;
    model4.img = @"left_icon_noraml";
    
    HomeItemModel *model5 = [[HomeItemModel alloc] init];
    model5.title = @"大礼包";
    model5.tag = 105;
    model5.img = @"left_icon_noraml";
    
    HomeItemModel *model6 = [[HomeItemModel alloc] init];
    model6.title = @"大礼包";
    model6.tag = 105;
    model6.img = @"left_icon_noraml";
    
    HomeItemModel *model7 = [[HomeItemModel alloc] init];
    model7.title = @"大礼包";
    model7.tag = 105;
    model7.img = @"left_icon_noraml";
    
    HomeItemModel *model8 = [[HomeItemModel alloc] init];
    model8.title = @"大礼包";
    model8.tag = 105;
    model8.img = @"left_icon_noraml";
    
    NSMutableArray *section1=[NSMutableArray array];
    
    [section1 addObject:model4];
    [section1 addObject:model5];
    [section1 addObject:model6];
    [section1 addObject:model7];
    [section1 addObject:model8];

    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, _centerView.bottom, self.frame.size.width, 216*.5)];
    bottomView.backgroundColor=[UIColor whiteColor];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, self.frame.size.width, 24)];
    title.text=@"我的礼品: 3";
    title.textColor=UIColorFromRGB(0x326294);
    [bottomView addSubview:title];
    
    for (int i=0; i<section1.count; i++) {
        HomeItemModel *obj=[section1 objectAtIndex:i];
        HomeGiftItemButton *btn=[[HomeGiftItemButton alloc]initWithFrame:CGRectMake(i*KMainScreenSize.width/5.0+4, title.bottom+2, (self.frame.size.width-8*2-4*3)/5.0, (self.frame.size.width-8*2-4*3)/5.0)];
        [btn setImage:[UIImage imageNamed:obj.img] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitle:obj.title forState:UIControlStateNormal];
        btn.layer.borderColor=[UIColor redColor].CGColor;
        btn.layer.cornerRadius=3.0;
        btn.layer.borderWidth=1.0;
        btn.layer.masksToBounds=YES;
        [bottomView addSubview:btn];
    }

    
    [self addSubview:bottomView];
    _bottomView=bottomView;
}

@end
