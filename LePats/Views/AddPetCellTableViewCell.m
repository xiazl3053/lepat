//
//  AddPetCellTableViewCell.m
//  LePats
//
//  Created by admin on 15/5/23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AddPetCellTableViewCell.h"

@implementation AddPetCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
    self.title.text=@"宠物名称:";
    [self addSubview:self.title];
    
    self.content=[[UITextField alloc]initWithFrame:CGRectMake(110, 0, 200, 44)];
    self.content.placeholder=@"请输入信息";
    [self addSubview:self.content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
