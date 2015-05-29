//
//  HomeItemCollectionCell.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeItemCollectionCell.h"
#import "HomeItemButton.h"

@interface HomeItemCollectionCell (){
    HomeItemButton *_btn;
}

@end

@implementation HomeItemCollectionCell

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    HomeItemButton *btn=[[HomeItemButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    btn.layer.borderColor=[UIColor yellowColor].CGColor;
    btn.layer.borderWidth=1.0;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(userClickCell:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    _btn=btn;
}

-(void)setItemModel:(HomeItemModel *)model{
    [_btn setImage:[UIImage imageNamed:model.img] forState:UIControlStateNormal];
    _btn.tag=model.tag;
    [_btn setTitle:model.title forState:UIControlStateNormal];
}

-(void)userClickCell:(HomeItemButton *)btn{
    [self.delegate homeItemCollectionCell:self userClickHomeItemButton:btn];
}

@end
