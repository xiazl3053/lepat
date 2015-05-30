//
//  FirendCell.h
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearInfo.h"

@interface FriendCell : UITableViewCell

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *lblName;
@property (nonatomic,strong) UILabel *lblPet;
@property (nonatomic,strong) UILabel *lblInfo;
@property (nonatomic,strong) UILabel *lblDistance;
@property (nonatomic,strong) UIButton *btnAttention;
@property (nonatomic,strong) UIButton *btnPriLet;
@property (nonatomic,strong) UIImageView *imgHead;

-(void)setNearInfo:(NearInfo *)info;


@end
