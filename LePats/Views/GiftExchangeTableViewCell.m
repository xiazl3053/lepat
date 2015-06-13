//
//  GiftExchangeTableViewCell.m
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "GiftExchangeTableViewCell.h"
#import "UIView+Add.h"
#define KSpaceWidth 10

@interface GiftExchangeTableViewCell (){
    UIImageView *_img;
    UILabel *_title;
    UILabel *_like;
    UILabel *_number;
    UIImageView *_likeImg;
}

@end

@implementation GiftExchangeTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initViews];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    NSLog(@"%s",__FUNCTION__);
    _img.frame=CGRectMake(KSpaceWidth, KSpaceWidth, 40, 40);
    _title.frame=CGRectMake(_img.right+KSpaceWidth, 0, self.width-_img.right-KSpaceWidth*2, 30);
    _likeImg.frame=CGRectMake(_img.right+KSpaceWidth, _title.bottom+5, 20, 20);
    _like.frame=CGRectMake(_likeImg.right, _title.bottom, 50, 30);
    _number.frame=CGRectMake(_like.right, _title.bottom, 200, 30);
    
}

-(void)initViews{
    UIImageView *img=[[UIImageView alloc]init];
   
    UILabel *title=[[UILabel alloc]init];
    title.font=[UIFont systemFontOfSize:16];
    
    UIImageView *likeImg=[[UIImageView alloc]init];
    
    UILabel *like=[[UILabel alloc]init];
    like.textColor=[UIColor grayColor];
    like.font=[UIFont systemFontOfSize:14];
    
    UILabel *number=[[UILabel alloc]init];
    number.font=[UIFont systemFontOfSize:14];
    number.textColor=[UIColor grayColor];
    
    [self addSubview:img];
    [self addSubview:title];
    [self addSubview:likeImg];
    [self addSubview:like];
    [self addSubview:number];
    
    
    _img=img;
    _title=title;
    _like=like;
    _number=number;
    _likeImg=likeImg;
}

-(void)setValueWithGiftExchangeModel:(GIftExchangeModel *)model{
    _img.image=[UIImage imageNamed:@"my_gift_kind"];
    _likeImg.image=[UIImage imageNamed:@"my_gift_more"];
    _title.text=model.title;
    _like.text=@"1234";
    _number.text=[NSString stringWithFormat:@"已兑换: %@ 件",@"12"];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
