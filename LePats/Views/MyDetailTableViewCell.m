//
//  MyDetailCellTableViewCell.m
//  LePats
//
//  Created by admin on 15/5/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyDetailTableViewCell.h"

@interface MyDetailTableViewCell (){
    UIImageView *_icon;
    UILabel *_title;
    UILabel *_detail;
    UIImageView *_indicate;
}
@end

@implementation MyDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)initViews{
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.textColor=[UIColor whiteColor];
    _title=title;
    [self addSubview:title];
    
    UILabel *detail=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    detail.textColor=[UIColor whiteColor];
    _detail=detail;
    [self addSubview:detail];
    
    UIImageView *indicate=[[UIImageView alloc]initWithFrame:CGRectMake(title.right, 12, 20, 20)];
    indicate.image=[UIImage imageNamed:@"left_indicate"];
    _indicate=indicate;
    [self addSubview:indicate];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
