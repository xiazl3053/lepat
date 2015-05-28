//
//  FirendCell.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FriendCell.h"
#import "UIView+Extension.h"

@implementation FriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initView];
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _btnPriLet.frame = Rect(self.contentView.width-50,60, 44,44);
    _btnAttention.frame = Rect(self.contentView.width-100,60, 44, 44);
    _lblDistance.frame = Rect(self.contentView.width-100,30,80, 15);
    
    
    
}

/*
@property (nonatomic,strong) UILabel *lblName;
@property (nonatomic,strong) UILabel *lblPet;
@property (nonatomic,strong) UILabel *lblInfo;
@property (nonatomic,strong) UILabel *lblDistance;
@property (nonatomic,strong) UIButton *btnAttention;
@property (nonatomic,strong) UIButton *btnPriLet;
imgView
*/

-(void)initView
{
    _imgView = [[UIImageView alloc] initWithFrame:Rect(10, 10, 64,64)];
    
    _lblName = [[UILabel alloc] initWithFrame:Rect(60, 10, 160, 15)];
    
    _lblPet = [[UILabel alloc] initWithFrame:Rect(_lblName.x, 35, 160, 13)];
    
    _lblInfo = [[UILabel alloc] initWithFrame:Rect(_lblInfo.x, 60, 180, 13)];
    
    _lblDistance = [[UILabel alloc] initWithFrame:Rect(250,20,60, 13)];
    
    [_lblDistance setTextAlignment:NSTextAlignmentRight];
    
    _btnAttention = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _btnPriLet = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btnAttention setBackgroundColor:RGB(13, 205, 253)];
    [_btnPriLet setBackgroundColor:RGB(95, 202, 8)];
    [_btnPriLet setTitle:@"私信" forState:UIControlStateNormal];
    [_btnAttention setTitle:@"关注" forState:UIControlStateNormal];
    [_btnAttention setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPriLet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnPriLet.titleLabel.font = XCFONT(12);
    _btnAttention.titleLabel.font = XCFONT(12);
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_lblName];
    [self.contentView addSubview:_lblPet];
    [self.contentView addSubview:_lblInfo];
    
    [self.contentView addSubview:_lblDistance];
    
    [self.contentView addSubview:_btnAttention];
    
    [self.contentView addSubview:_btnPriLet];
    
}

-(void)setNearInfo
{
    
}


@end
