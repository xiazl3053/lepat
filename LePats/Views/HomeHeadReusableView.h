//
//  HomeHeadReusableView.h
//  LePats
//
//  Created by admin on 15/5/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeHeadReusableView;
@protocol HomeHeadReusableViewDelegate <NSObject>

-(void)homeHeadReusableView:(HomeHeadReusableView *)view selectButton:(UIButton *)abtn;

@end

@interface HomeHeadReusableView : UICollectionReusableView
@property (nonatomic,assign) id<HomeHeadReusableViewDelegate> delegate;
@end
