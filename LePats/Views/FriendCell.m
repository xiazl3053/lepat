//
//  FirendCell.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FriendCell.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

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
}

-(void)addViewLine
{
    UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0.1,kScreenSourchWidth,0.5)];
    sLine1.backgroundColor = [UIColor colorWithRed:237/255.0
                                             green:237/255.0
                                              blue:237/255.0
                                             alpha:1.0];
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0,0.6,kScreenSourchWidth, 0.5)] ;
    sLine2.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:sLine1];
    [self.contentView addSubview:sLine2];
    
}

-(void)imgTapEvent
{
    if (_delegate && [_delegate respondsToSelector:@selector(friendView:index:)])
    {
        [_delegate friendView:self index:self.nRow];
    }
}

-(void)initView
{
    _imgView = [[UIImageView alloc] initWithFrame:Rect(10, 10, 64,64)];
    [_imgView.layer setMasksToBounds:YES];
    _imgView.layer.cornerRadius = 32.0f;
    
    _imgHead = [[UIImageView alloc] initWithFrame:Rect(84, 6, 20, 20)];
    
    _lblName = [[UILabel alloc] initWithFrame:Rect(106, 10, 160, 15)];
    
    _lblPet = [[UILabel alloc] initWithFrame:Rect(84, 40, 160, 13)];
    
    _lblInfo = [[UILabel alloc] initWithFrame:Rect(84, 65, 180, 13)];
    
    [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapEvent)]];
    [_imgView setUserInteractionEnabled:YES];
    
    _lblDistance = [[UILabel alloc] initWithFrame:Rect(kScreenSourchWidth-80,20,60, 13)];
    
    [_lblDistance setTextAlignment:NSTextAlignmentRight];
    
    _btnAttention = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _btnPriLet = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_btnPriLet setBackgroundImage:[UIImage imageNamed:@"find_prilet"] forState:UIControlStateNormal];
    [_btnAttention setBackgroundImage:[UIImage imageNamed:@"find_atten"] forState:UIControlStateNormal];
    
    [_btnPriLet setTitle:@"私信" forState:UIControlStateNormal];
    [_btnAttention setTitle:@"关注" forState:UIControlStateNormal];
    
    [_btnAttention setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnPriLet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_btnAttention.layer setMasksToBounds:YES];
    [_btnAttention.layer setCornerRadius:2.0f];
    [_btnPriLet.layer setMasksToBounds:YES];
    [_btnPriLet.layer setCornerRadius:2.0f];
    
    _btnPriLet.titleLabel.font = XCFONT(12);
    _btnAttention.titleLabel.font = XCFONT(12);
    
    [_lblName setFont:XCFONT(15)];
    [_lblName setTextColor:RGB(254, 153, 0)];
    [_lblPet setFont:XCFONT(14)];
    [_lblInfo setFont:XCFONT(12)];
    [_lblDistance setFont:XCFONT(12)];
    
    _btnPriLet.frame = Rect(kScreenSourchWidth-60,40, 55,24);
    _btnAttention.frame = Rect(kScreenSourchWidth-120,40, 55, 24);
    _lblDistance.frame = Rect(kScreenSourchWidth-85,15,80, 15);
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_imgHead];
    [self.contentView addSubview:_lblName];
    [self.contentView addSubview:_lblPet];
    [self.contentView addSubview:_lblInfo];
    [self.contentView addSubview:_lblDistance];
    
    [self.contentView addSubview:_btnAttention];
    [self.contentView addSubview:_btnPriLet];
    [_btnAttention addTarget:self action:@selector(focusEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addViewLine];
}

-(void)setNearInfo:(NearInfo *)nearInfo
{
    _lblName.text = nearInfo.strName;
    _lblInfo.text = nearInfo.strContent;
    _lblPet.text = [NSString stringWithFormat:@"TA的宠物:"];
    float dis=nearInfo.fDistan/2000;
    if (dis<1) {
        [_lblDistance setText:[NSString stringWithFormat:@"%.02f 米",nearInfo.fDistan]];
    }else{
        [_lblDistance setText:[NSString stringWithFormat:@"%.02f 公里",dis]];
    }
    
    _strUserId = nearInfo.strUserId;
    NSString *strInfo = nearInfo.nFocus ? @"取消关注" : @"关注";
    [_btnAttention setTitle:strInfo forState:UIControlStateNormal];
    
    _imgHead.image = nearInfo.nSex ? [UIImage imageNamed:@"boy"] : [UIImage imageNamed:@"girl"];
    [_imgView setImage:[UIImage imageNamed:@"left_icon_noraml"]];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:nearInfo.strFile] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    //[self setImageInfo:nearInfo.strFile];
}

-(void)setAttenBtnSwtich
{
    if ([_btnAttention.titleLabel.text isEqualToString:@"关注"])
    {
        [_btnAttention setTitle:@"取消关注" forState:UIControlStateNormal];// = @"取消关注";
    }
    else
    {
        [_btnAttention setTitle:@"关注" forState:UIControlStateNormal];// = @"取消关注";
    }
}

-(void)setImageInfo:(NSString *)strImage
{
    if ([strImage isEqualToString:@""]) {
        
        [_imgView setImage:[UIImage imageNamed:@""]];
        return ;
    }
    __block NSString *__strImg = strImage;
    __weak FriendCell *__self = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *imgDest = nil;
        NSURL *url = [NSURL URLWithString:__strImg];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        imgDest = [UIImage imageWithData:responseData];
        if (imgDest)
        {
            __strong UIImage *__imageDest = imgDest;
            __strong FriendCell *__strongSelf = __self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [__strongSelf thread_setImgView:__imageDest];
            });
        }
    });
}

-(void)thread_setImgView:(UIImage *)image
{
    _imgView.image = image;
}

-(void)focusEvent
{
    if (_delegate && [_delegate respondsToSelector:@selector(friendView:focus:)])
    {
        [_delegate friendView:self focus:_strUserId];
    }
}



@end
