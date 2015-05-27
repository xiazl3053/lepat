//
//  MyPetTableViewCell.m
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyPetTableViewCell.h"

@interface MyPetTableViewCell (){
    UIImageView *_icon;
    UILabel *_name;
    UILabel *_age;
}
@end

@implementation MyPetTableViewCell

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
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(icon.right+10, 2, 100, 20)];
    name.font=[UIFont systemFontOfSize:14];
    _name=name;
    [self addSubview:name];
    
    UILabel *age=[[UILabel alloc]initWithFrame:CGRectMake(icon.right+10, name.bottom, 100, 20)];
    age.font=[UIFont systemFontOfSize:14];
    _age=age;
    [self addSubview:age];
    
    UIImageView *map=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 12, 20, 20)];
    map.image=[UIImage imageNamed:@"left_indicate"];
    [self addSubview:map];
}

-(void)setValueWithPetInfo:(LePetInfo *)pet{
    _icon.image=[UIImage imageNamed:@"left_icon_noraml"];
    _name.text=[NSString stringWithFormat:@"%@",pet.strName];
    _age.text=[NSString stringWithFormat:@"%d %@",pet.nSortId,pet.strBirthday];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
