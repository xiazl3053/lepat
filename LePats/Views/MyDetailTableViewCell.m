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
    UILabel *_content;
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
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 44)];
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:14];
    _title=title;
    [self addSubview:title];
    
    UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(title.right, 0, 200, 44)];
    content.textColor=[UIColor blackColor];
    content.font=[UIFont systemFontOfSize:14];
    _content=content;
    [self addSubview:content];
    
    UIImageView *indicate=[[UIImageView alloc]initWithFrame:CGRectMake(KMainScreenSize.width-30, 12, 20, 20)];
    indicate.image=[UIImage imageNamed:@"left_indicate"];
    _indicate=indicate;
    [self addSubview:indicate];
}

-(void)setValueWithNSDictionay:(NSDictionary *)dic{
    [_title setText:[dic objectForKey:@"title"]];
    [_content setText:[dic objectForKey:@"content"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
