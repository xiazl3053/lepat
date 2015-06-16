//
//  MyButton.m
//  LePats
//
//  Created by admin on 15/6/8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyButton.h"

@interface MyButton (){
    UILabel *_number;
    UILabel *_title;

}

@end

@implementation MyButton

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    UILabel *number=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-20)];
    number.textAlignment=NSTextAlignmentCenter;
    number.textColor=[UIColor whiteColor];
    number.font=[UIFont systemFontOfSize:14];
    [self addSubview:number];
    _number=number;

    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(0, number.bottom, self.width, 20)];
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:14];
    [self addSubview:title];
    _title=title;
}

-(void)setValueWithUserOperationModel:(UserOperationModel *)model{
    _number.text=[NSString stringWithFormat:@"%i",model.number];
    _title.text=model.title;
    self.tag=model.tag;
}

-(void)setValueWithNumber:(NSString *)number{
    _number.text=[NSString stringWithFormat:@"%@",number];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
