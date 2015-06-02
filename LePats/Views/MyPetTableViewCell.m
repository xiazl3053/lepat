//
//  MyPetTableViewCell.m
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyPetTableViewCell.h"
#import "PetSort.h"

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

-(void)initViews
{
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(30, 7, 30, 30)];
    _icon=icon;
    [self addSubview:icon];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(icon.right+10, 2, 100, 20)];
    name.font=[UIFont systemFontOfSize:14];
    _name=name;
    [self addSubview:name];
    
    UILabel *age=[[UILabel alloc]initWithFrame:CGRectMake(icon.right+10, name.bottom, 150, 20)];
    age.font=[UIFont systemFontOfSize:14];
    _age=age;
    [self addSubview:age];
    
    UIButton *map=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-30, 12, 20, 20)];
    [map setImage:[UIImage imageNamed:@"position"] forState:UIControlStateNormal];
    [map addTarget:self action:@selector(gotoMap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:map];
    map.tag = 10001;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    DLog(@"width:%f",self.contentView.frame.size.width);
    [self viewWithTag:10001].frame = Rect(self.contentView.frame.size.width-30, 12, 20, 20);
}

-(void)setValueWithPetInfo:(LePetInfo *)pet{
    [_icon sd_setImageWithURL:[NSURL URLWithString:pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    //[_icon setImage:[UIImage imageNamed:@"left_icon_noraml"]];
    _name.text=[NSString stringWithFormat:@"%@",pet.strName];
    _age.text=[NSString stringWithFormat:@"%@ %@",[[PetSort sharedPetSort]getPetNameWithiD:pet.nSortId],pet.strBirthday];
}

-(void)gotoMap:(UIButton *)aBtn{
    [self.delegate MyPetTableViewCell:self clickMap:aBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
