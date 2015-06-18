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
}
@end

@implementation MyDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initViews
{
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(10, (self.frame.size.height-44)*.5, 90, 44)];
    _title.textColor=[UIColor blackColor];
    _title.font=[UIFont systemFontOfSize:14];
    [self addSubview:_title];
    
    self.content=[[UITextField alloc]initWithFrame:CGRectMake(_title.right, 0, 200, 44)];
    _content.textColor=[UIColor blackColor];
    _content.userInteractionEnabled=NO;
    _content.font=[UIFont systemFontOfSize:14];
    [self addSubview:_content];
    
    self.indicate=[[UIImageView alloc]initWithFrame:CGRectMake(KMainScreenSize.width-30, 12, 20, 20)];
    _indicate.image=[UIImage imageNamed:@"left_indicate"];
    [self addSubview:_indicate];
}

-(void)setValueWithNSDictionay:(NSDictionary *)dic
{
    [_title setText:[dic objectForKey:@"title"]];
    [_content setText:[dic objectForKey:@"content"]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
