//
//  LeftTableViewCell.m
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LeftTableViewCell.h"

@interface LeftTableViewCell (){
    UIImageView *_icon;
    UILabel *_title;
    UIImageView *_indicate;
}
@end

@implementation LeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)initViews{
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(30, 7, 30, 30)];
    _icon=icon;
    [self addSubview:icon];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(icon.right+10, 0, 150, 44)];
    title.textColor=[UIColor whiteColor];
    _title=title;
    [self addSubview:title];
    
    UIImageView *indicate=[[UIImageView alloc]initWithFrame:CGRectMake(title.right, 12, 20, 20)];
    indicate.image=[UIImage imageNamed:@"left_indicate"];
    _indicate=indicate;
    [self addSubview:indicate];
}

-(void)setValueWithHomeItemModel:(HomeItemModel *)model{
    _icon.image=[UIImage imageNamed:model.img];
    _title.text=model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
