//
//  MyViewController.m
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyViewController.h"
#import "MyDetailViewController.h"
#import "UserInfo.h"
#import "MyInfoService.h"
#import "LoginViewController.h"
#import "ProgressHUD.h"

@interface MyViewController (){
    UIImageView *_headView;
    UIView *_detailView;
    UISegmentedControl *_segmentedView;
    UIView *_leftView;
    UIView *_rightView;
    UIImageView *_icon;
}

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initViews{
    [self initSelfView];
    [self initHeadView];
    [self initDetailView];
    [self initIconView];
    [self initSegment];
    [self initContentView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    if ([UserInfo sharedUserInfo].strToken) {
        [self getUserInfo];
        _detailView.hidden=NO;
        //_headView.hidden=YES;
        _leftView.hidden=NO;
        _rightView.hidden=NO;
        _segmentedView.hidden=NO;
    }else{
        _detailView.hidden=YES;
        //_headView.hidden=YES;
        _leftView.hidden=YES;
        _rightView.hidden=YES;
        _segmentedView.hidden=YES;
    }
    
}

-(void)getUserInfo{
    MyInfoService *service=[[MyInfoService alloc]init];
    service.getMyInfoBlock=^(NSString *error){
        [_icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    };
    [service requestUserId:0];
}

-(void)initSelfView{
    self.title=@"我的";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initHeadView{
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 200)];
    head.image=[UIImage imageNamed:@"headView_bg"];
    _headView=head;
    [self.view addSubview:head];
}

-(void)initDetailView{
    UIView *detail=[[UIView alloc]initWithFrame:CGRectMake(0, _headView.bottom, KMainScreenSize.width, 160)];
    detail.backgroundColor=[UIColor whiteColor];
    detail.layer.borderColor=[UIColor blackColor].CGColor;
    detail.layer.borderWidth=0.5;
    
    UILabel *nick=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, KMainScreenSize.width, 20)];
    nick.text=[UserInfo sharedUserInfo].strNickName;
    nick.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:nick];
    
    UILabel *sign=[[UILabel alloc]initWithFrame:CGRectMake(0, nick.bottom+10, KMainScreenSize.width, 20)];
    sign.text=[UserInfo sharedUserInfo].strSignature;
    sign.textColor=[UIColor grayColor];
    sign.font=[UIFont systemFontOfSize:14];
    if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""]) {
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
    
    UILabel *fans1=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    fans1.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
    fans1.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:fans1];
    
    UIButton *fansTitle1=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [fansTitle1 setTitle:@"其他" forState:UIControlStateNormal];
    [fansTitle1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansTitle1 addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    fansTitle1.tag=300;
    [detail addSubview:fansTitle1];
    
    UILabel *fans2=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    fans2.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
    fans2.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:fans2];
    
    UIButton *fansTitle2=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [fansTitle2 setTitle:@"其他" forState:UIControlStateNormal];
    [fansTitle2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansTitle2 addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    fansTitle2.tag=400;
    [detail addSubview:fansTitle2];
    
    
    [self.view addSubview:detail];
    _detailView=detail;
}

-(void)initIconView{
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, _detailView.top-60, 80, 80)];
    //icon.backgroundColor=[UIColor redColor];
    icon.image=[UIImage imageNamed:@"headView_bg"];
    icon.layer.cornerRadius= icon.bounds.size.width/2;
    icon.layer.masksToBounds=YES;
    icon.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myDetail:)];
    [icon addGestureRecognizer:tap];
    [_icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    _icon=icon;
    [self.view addSubview:icon];
}

-(void)initSegment{
    NSArray *arr=[NSArray arrayWithObjects:@"我发布的",@"我喜欢的",nil];
    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:arr];
    segment.segmentedControlStyle=UISegmentedControlStyleBordered;
    segment.frame=CGRectMake(0, _detailView.bottom, KMainScreenSize.width, 40);
    [segment setSelectedSegmentIndex:0];
    [self.view addSubview:segment];
    [segment addTarget:self action:@selector(segmentedValueChange:) forControlEvents:UIControlEventValueChanged];
    _segmentedView=segment;
}

-(void)initContentView{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, _segmentedView.bottom, KMainScreenSize.width, self.view.frame.size.height-_segmentedView.bottom-44)];
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
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, _segmentedView.bottom, KMainScreenSize.width, self.view.frame.size.height-_segmentedView.bottom-44)];
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

-(void)segmentedValueChange:(UISegmentedControl *)segmented{
    NSLog(@"segmented.selectedSegmentIndex=%li",segmented.selectedSegmentIndex);
    switch (segmented.selectedSegmentIndex) {
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


-(void)gotoOther:(UIButton *)aBtn{
    switch (aBtn.tag) {
        case 100:
        {
            MyViewController *other=[[MyViewController alloc]init];
            [self.navigationController pushViewController:other animated:YES];
        }break;
            
        default:
            break;
    }
}

-(void)myDetail:(UITapGestureRecognizer *)tap{
    if ([UserInfo sharedUserInfo].strToken) {
        MyDetailViewController *detail=[[MyDetailViewController alloc]init];
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];
        NSLog(@"%s",__FUNCTION__);
    }else{
        
        LoginViewController *login=[[LoginViewController alloc]init];
        [self presentViewController:login animated:YES completion:^{
            
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
