//
//  RecordTableViewCell.m
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "RecordTableViewCell.h"
#define KSpaceWidth 10

@interface RecordTableViewCell (){
    UILabel *_title;
    UILabel *_time;
    UILabel *_score;

}

@end

@implementation RecordTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initViews];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _title.frame=CGRectMake(KSpaceWidth*2, KSpaceWidth, 150, 20);
    _time.frame=CGRectMake(KSpaceWidth*2, _title.bottom, 150, 20);
    _score.frame=CGRectMake(KMainScreenSize.width-110, 0, 100, self.height);
    
}

-(void)initViews{
    
    UILabel *title=[[UILabel alloc]init];
    title.textColor=UIColorFromRGB(0x22282b);
    title.font=[UIFont systemFontOfSize:16];
    
    UILabel *time=[[UILabel alloc]init];
    time.textColor=UIColorFromRGB(0x9a9a9a);
    time.font=[UIFont systemFontOfSize:14];
    
    UILabel *score=[[UILabel alloc]init];
    score.textColor=UIColorFromRGB(0x1b99fb);
    score.font=[UIFont systemFontOfSize:14];
    score.textAlignment=NSTextAlignmentRight;
    
    [self addSubview:title];
    [self addSubview:time];
    [self addSubview:score];
    _title=title;
    _time=time;
    _score=score;
}

-(void)setValueWithRecordModel:(RecordModel *)model{
    _title.text=model.title;
    NSDate *fromdate=[NSDate dateWithTimeIntervalSince1970:model.time];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString* string=[dateFormat stringFromDate:fromdate];
    _time.text=string;
    _score.text=[NSString stringWithFormat:@"+ %li个积分 ",model.score];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
