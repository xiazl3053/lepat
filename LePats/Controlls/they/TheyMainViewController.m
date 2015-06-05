//
//  TheyMainViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TheyMainViewController.h"
#import "UserInfo.h"
#import "NearInfo.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@interface TheyMainViewController()
{
    UIImageView *imgBack;
    UIImageView *imgHead;
    UIView *detail;
    UIButton *btnBack;
    NearInfo *_nearInfo;
    UIView *_leftView;
    UIView *_rightView;
}

@end

@implementation TheyMainViewController

-(id)initWithNear:(NearInfo *)near
{
    self = [super init];
    
    _nearInfo = near;
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TA的信息";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initImgView];
    [self initDetailView];
    [self initBodyView];
}

-(void)initImgView
{
    imgBack=[[UIImageView alloc]initWithFrame:Rect(0, [self barSize].height, KMainScreenSize.width, 200)];
    imgBack.image=[UIImage imageNamed:@"headView_bg"];
    [self.view addSubview:imgBack];
   
    imgHead=[ [UIImageView alloc] initWithFrame:Rect((KMainScreenSize.width-80)*.5, imgBack.y+140, 80, 80)];
    //icon.backgroundColor=[UIColor redColor];
    imgHead.layer.cornerRadius= imgHead.bounds.size.width/2;
    imgHead.layer.masksToBounds=YES;
    imgHead.userInteractionEnabled=YES;
    [imgHead sd_setImageWithURL:[[NSURL alloc] initWithString:_nearInfo.strFile] placeholderImage:[UIImage imageNamed:@""]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(theyDetail)];
    
    [imgHead addGestureRecognizer:tap];
    [self.view addSubview:imgHead];
}

-(void)navBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initBodyView
{
    NSArray *arr = [NSArray arrayWithObjects:@"他的发布",@"他的宠物",nil];
    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:arr];
    segment.segmentedControlStyle = UISegmentedControlStyleBordered;
    segment.frame=CGRectMake(0, detail.bottom , KMainScreenSize.width, 40);
    [segment setSelectedSegmentIndex:0];
    [self.view addSubview:segment];
    [segment addTarget:self action:@selector(segmentedValueChange:) forControlEvents:UIControlEventValueChanged];
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, KMainScreenSize.width, self.view.frame.size.height-segment.bottom)];
    view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIImageView *push=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, (view1.height-80)*.5, 80, 80)];
    push.image=[UIImage imageNamed:@"my_camera"];
    [view1 addSubview:push];
    
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,push.bottom-20, 280, 80)];
    text.text=@"青春的时光很短，我们也过得匆忙。我们不能让时光的飞逝慢一点，只能用镜头记录每一个美好瞬间，留作纪念";
    text.font=[UIFont systemFontOfSize:10];
    text.backgroundColor=[UIColor clearColor];
    [view1 addSubview:text];
    
    _leftView=view1;
    [self.view addSubview:view1];
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, KMainScreenSize.width, self.view.frame.size.height-segment.bottom)];
    view2.backgroundColor=[UIColor groupTableViewBackgroundColor];
    view2.hidden=YES;
    
    UIImageView *like=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, (view2.height-80)*.5, 80, 80)];
    like.image=[UIImage imageNamed:@"my_heart"];
    [view2 addSubview:like];
    
    UILabel *text1=[[UILabel alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,like.bottom, 280, 20)];
    text1.text=@"您的喜欢还是空的！";
    text1.textAlignment=NSTextAlignmentCenter;
    text1.font=[UIFont systemFontOfSize:10];
    text1.backgroundColor=[UIColor clearColor];
    [view2 addSubview:text1];
    _rightView=view2;
    
    [self.view addSubview:view2];
}

-(void)segmentedValueChange:(UISegmentedControl *)segmengt
{
    NSLog(@"segmented.selectedSegmentIndex=%li",segmengt.selectedSegmentIndex);
    switch (segmengt.selectedSegmentIndex) {
        case 0:
        {
            _rightView.hidden=YES;
            _leftView.hidden=NO;
        }break;
        case 1:
        {
            _leftView.hidden=YES;
            _rightView.hidden=NO;
        }break;
            
        default:
            break;
    }
}

-(void)initDetailView
{
    detail=[[UIView alloc]initWithFrame:CGRectMake(0, imgHead.y+imgHead.height+20, KMainScreenSize.width, 120)];
    
    UILabel *nick=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, KMainScreenSize.width, 20)];
    nick.text = _nearInfo.strName;
    nick.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:nick];
    
    UILabel *sign=[[UILabel alloc]initWithFrame:CGRectMake(0, nick.bottom+10, KMainScreenSize.width, 20)];
    sign.text=[UserInfo sharedUserInfo].strSignature;
    sign.textColor=[UIColor grayColor];
    sign.font=[UIFont systemFontOfSize:14];
    if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""])
    {
        sign.text=@"这个人很懒,什么都没有留下.";
    }
    sign.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:sign];
    
    UILabel *focus=[[UILabel alloc]initWithFrame:CGRectMake(0, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    focus.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFocusNum];
    focus.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:focus];
    
    UIButton *focusTitle=[[UIButton alloc]initWithFrame:CGRectMake(0, focus.bottom+5, KMainScreenSize.width*.25, 20)];
    [focusTitle setTitle:@"关注" forState:UIControlStateNormal];
    [focusTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [focusTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    focusTitle.tag=100;
    [detail addSubview:focusTitle];
    
    
    UILabel *fans=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.25, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    fans.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
    fans.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:fans];
    
    UIButton *fansTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.25, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [fansTitle setTitle:@"粉丝" forState:UIControlStateNormal];
    [fansTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    fansTitle.tag=200;
    [detail addSubview:fansTitle];
    
    UILabel *heart=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    heart.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
    heart.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:heart];
    
    UIButton *heratTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [heratTitle setTitle:@"赞" forState:UIControlStateNormal];
    [heratTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [heratTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    heratTitle.tag=300;
    [detail addSubview:heratTitle];
    
    UILabel *commet=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    commet.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
    commet.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:commet];
    
    UIButton *commetTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [commetTitle setTitle:@"评论" forState:UIControlStateNormal];
    [commetTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commetTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    commetTitle.tag=400;
    [detail addSubview:commetTitle];
    [self.view addSubview:detail];
    
//    UILabel *lblContent = [[UILabel alloc] initWithFrame:Rect(0, detail.y+detail.height+10, kScreenSourchWidth, 1)];
//    [lblContent setBackgroundColor:RGB(240, 240, 240)];
//    [self.view addSubview:lblContent];
}

-(void)gotoOther:(UIButton *)btnSender
{
    
}

-(void)getUserInfo
{
    
}

-(void)theyDetail
{
    
}

@end
