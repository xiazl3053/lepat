//
//  TheyMainViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/6/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "TheyMainViewController.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "LePetInfo.h"
#import "Toast+UIView.h"
#import "NearInfo.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "TheyInfoService.h"
#import "TUserService.h"
#import "LoginViewController.h"

@interface TheyMainViewController()
{
    UIImageView *imgBack;
    UIImageView *imgHead;
    UIView *detail;
    UIButton *btnBack;
    NearInfo *_nearInfo;
    UIView *_leftView;
    UIView *_rightView;
    TheyInfoService *theyInfo;
    UIScrollView *scrollView;
    TUserService *tUser;
}
@property (nonatomic,strong) NSMutableArray *aryPets;
@end

@implementation TheyMainViewController

-(id)initWithNear:(NearInfo *)near
{
    self = [super init];
    _aryPets = [NSMutableArray array];
    _nearInfo = near;
    
    return self;
}

-(void)requestTheyInfo
{
    if (theyInfo==nil)
    {
        theyInfo = [[TheyInfoService alloc] init];
    }
    __weak TheyMainViewController *__self = self;
    theyInfo.httpBlock = ^(int nStatus,NSArray *aryItem)
    {
        if (nStatus == 1)
        {
            [__self.aryPets removeAllObjects];
            [__self.aryPets addObjectsFromArray:aryItem];
//            dispatch_async(dispatch_get_main_queue(), )
            [__self updateRightView];
        }
        else if(nStatus == 50003)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [__self.view makeToast:@"登录信息超时"];
                LoginViewController *loginView = [[LoginViewController alloc] init];
                [[UIApplication sharedApplication].keyWindow setRootViewController:loginView];
            });
        }
    };
    [theyInfo requestUserId:_nearInfo.strUserId];
}

-(void)updateRightView
{
    for (UIView *view in scrollView.subviews)
    {
        [view removeFromSuperview];
    }
    //60
    CGFloat width = kScreenSourchWidth/4-5;//105
    int x=0,y=0;
    //1行  4 个
    for (LePetInfo *lepet in _aryPets)
    {
        DLog(@"length:%@",lepet.strIconUrl);
        if(![lepet.strIconUrl isEqualToString:@""])
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:Rect((x%4)*(width+5)+5, y/4*(width+5)+5,width,width)];
            [scrollView addSubview:imgView];
            [imgView sd_setImageWithURL:[[NSURL alloc] initWithString:lepet.strIconUrl] placeholderImage:nil];
            x++;
            y++;
        }
    }
    [scrollView setContentSize:CGSizeMake(kScreenSourchWidth,(y/4+1)*(width+5))];
}

-(void)requestTUser
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestTheyInfo];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    tUser = [[TUserService alloc] init];
    self.title = @"TA的信息";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initImgView];
    [self initDetailView];
    [self initBodyView];
}

-(void)initImgView
{
    imgBack=[[UIImageView alloc]initWithFrame:Rect(0, [self barSize].height, KMainScreenSize.width, 120)];
    imgBack.image=[UIImage imageNamed:@"headView_bg"];
    [self.view addSubview:imgBack];
   
    imgHead=[ [UIImageView alloc] initWithFrame:Rect((KMainScreenSize.width-80)*.5, imgBack.y+60, 80, 80)];
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
    
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,push.bottom, 280, 80)];
    text.text=@"青春的时光很短，我们也过得匆忙。我们不能让时光的飞逝慢一点，只能用镜头记录每一个美好瞬间，留作纪念";
    text.font=[UIFont systemFontOfSize:10];
    text.backgroundColor=[UIColor clearColor];
    [view1 addSubview:text];
    
    _leftView=view1;
    [self.view addSubview:view1];
    
    _rightView=[[UIView alloc]initWithFrame:CGRectMake(0, segment.bottom, KMainScreenSize.width, self.view.frame.size.height-segment.bottom)];
    _rightView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _rightView.hidden=YES;
   
    scrollView = [[UIScrollView alloc] initWithFrame:_rightView.bounds];
    [_rightView addSubview:scrollView];
    [self.view addSubview:_rightView];
    
    
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
    
    UILabel *nick=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, KMainScreenSize.width, 15)];
    nick.text = _nearInfo.strName;
    nick.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:nick];
    [nick setFont:XCFONT(14)];
    
    UILabel *sign=[[UILabel alloc]initWithFrame:CGRectMake(0, nick.bottom+5, KMainScreenSize.width, 15)];
    sign.text=[UserInfo sharedUserInfo].strSignature;
    sign.textColor=[UIColor grayColor];
    sign.font=[UIFont systemFontOfSize:14];
    [sign setFont:XCFONT(12)];
    if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""])
    {
        sign.text=@"这个人很懒,什么都没有留下.";
    }
    sign.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:sign];
    
    UILabel *focus=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.20, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    focus.text=[NSString stringWithFormat:@"%d",_nearInfo.nFocusNum];
    focus.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:focus];
    
    UIButton *focusTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.20, focus.bottom+5, KMainScreenSize.width*.25, 20)];
    [focusTitle setTitle:@"关注" forState:UIControlStateNormal];
    [focusTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [focusTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    focusTitle.tag=100;
    [detail addSubview:focusTitle];
    
    
    UILabel *fans=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*0.6, sign.bottom+10, KMainScreenSize.width*.25, 20)];
    fans.text=[NSString stringWithFormat:@"%d",_nearInfo.nFansNum];
    fans.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:fans];
    
    UIButton *fansTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*0.6, fans.bottom+5, KMainScreenSize.width*.25, 20)];
    [fansTitle setTitle:@"粉丝" forState:UIControlStateNormal];
    [fansTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fansTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
    fansTitle.tag=200;
    [detail addSubview:fansTitle];
    
//    UILabel *heart=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, sign.bottom+10, KMainScreenSize.width*.25, 20)];
//    heart.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
//    heart.textAlignment=NSTextAlignmentCenter;
//    [detail addSubview:heart];
//    
//    UIButton *heratTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.5, fans.bottom+5, KMainScreenSize.width*.25, 20)];
//    [heratTitle setTitle:@"赞" forState:UIControlStateNormal];
//    [heratTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [heratTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
//    heratTitle.tag=300;
//    [detail addSubview:heratTitle];
//    
//    UILabel *commet=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, sign.bottom+10, KMainScreenSize.width*.25, 20)];
//    commet.text=[NSString stringWithFormat:@"%@",[UserInfo sharedUserInfo].strFansNum];
//    commet.textAlignment=NSTextAlignmentCenter;
//    [detail addSubview:commet];
//    
//    UIButton *commetTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.75, fans.bottom+5, KMainScreenSize.width*.25, 20)];
//    [commetTitle setTitle:@"评论" forState:UIControlStateNormal];
//    [commetTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [commetTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
//    commetTitle.tag=400;
//    [detail addSubview:commetTitle];
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
