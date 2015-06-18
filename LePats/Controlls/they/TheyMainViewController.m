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
#import "MyFansViewController.h"
#import "MyFocusViewController.h"
#import "LeftImgButton.h"
#import "UserOperationModel.h"
#import "MyButton.h"
#import "FocusService.h"
#import "RelationService.h"
#import "TwoTitleButton.h"
#import "PetImageView.h"
#import "PetDetailViewController.h"

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
    UIButton *_releaseBtn;
    UIButton *_likeBtn;
    UIView *_line;
    UIView *_statusView;
    LeftImgButton *_focusBtn;
    RelationService *relationService;
    FocusService *focus;
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

-(void)requestRelation{
    __weak typeof(self) weakSelf =self;
    if (relationService==nil) {
        relationService=[[RelationService alloc]init];
    }
    relationService.relationBlock=^(NSString *error,NSInteger code){
        if (error) {
           // [weakSelf.view makeToast:error];
        }else{
            [_focusBtn setTitle:[weakSelf isFocusFromFocusCode:code] forState:UIControlStateNormal];
        }
    };
    [relationService requestOperId:_nearInfo.strUserId];
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
            PetImageView *imgView = [[PetImageView alloc] initWithFrame:Rect((x%4)*(width+5)+5, y/4*(width+5)+5,width,width)];
            [scrollView addSubview:imgView];
            imgView.petInfo=lepet;
            [imgView sd_setImageWithURL:[[NSURL alloc] initWithString:lepet.strIconUrl] placeholderImage:nil];
            imgView.userInteractionEnabled=YES;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPetDetail:)];
            [imgView addGestureRecognizer:tap];
            x++;
            y++;
        }
    }
    [scrollView setContentSize:CGSizeMake(kScreenSourchWidth,(y/4+1)*(width+5))];
}

-(void)gotoPetDetail:(UITapGestureRecognizer *)gesTure{
    PetImageView *image=( PetImageView *)gesTure.view;
    PetDetailViewController *pet=[[PetDetailViewController alloc]init];
    pet.type=PetType_TA;
    pet.nPetId=image.petInfo.nPetId;
    [self.navigationController pushViewController:pet animated:YES];
    
}

-(void)requestTUser
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self requestTheyInfo];
    [self requestRelation];
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
    imgBack=[[UIImageView alloc]initWithFrame:Rect(0, [self barSize].height, KMainScreenSize.width, 260)];
    imgBack.image=[UIImage imageNamed:@"they_bgView"];
    [self.view addSubview:imgBack];
   
    imgHead=[ [UIImageView alloc] initWithFrame:Rect((KMainScreenSize.width-80)*.5, imgBack.y+30, 80, 80)];
    //icon.backgroundColor=[UIColor redColor];
    imgHead.layer.cornerRadius= imgHead.bounds.size.width/2;
    imgHead.layer.masksToBounds=YES;
    imgHead.userInteractionEnabled=YES;
    [imgHead sd_setImageWithURL:[[NSURL alloc] initWithString:_nearInfo.strFile] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    
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
//    NSArray *arr = [NSArray arrayWithObjects:@"TA的发布",@"TA的宠物",nil];
//    UISegmentedControl *segment=[[UISegmentedControl alloc]initWithItems:arr];
//    segment.segmentedControlStyle = UISegmentedControlStyleBordered;
//    segment.frame=CGRectMake(0, detail.bottom , KMainScreenSize.width, 40);
//    [segment setSelectedSegmentIndex:0];
//    [self.view addSubview:segment];
//    [segment addTarget:self action:@selector(segmentedValueChange:) forControlEvents:UIControlEventValueChanged];
    
    UIView *segment=[[UIView alloc]initWithFrame:CGRectMake(0, detail.bottom, KMainScreenSize.width, 40)];
    segment.backgroundColor=[UIColor grayColor];
    [self.view addSubview:segment];
    
    
    UIButton *release=[[UIButton alloc]initWithFrame:CGRectMake(0, 0.5, KMainScreenSize.width*.5, 40)];
    release.backgroundColor=[UIColor whiteColor];
    [release setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [release setTitleColor:UIColorFromRGB(0x646566) forState:UIControlStateNormal];
    [release setTitle:@"TA的发布" forState:UIControlStateNormal];
    release.tag=100;
    [segment addSubview:release];
    [release addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [release setSelected:YES];
    
    _releaseBtn=release;
    
    UIButton *like=[[UIButton alloc]initWithFrame:CGRectMake(release.right, .5, KMainScreenSize.width*.5, 40)];
    like.backgroundColor=[UIColor whiteColor];
    [like setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [like setTitleColor:UIColorFromRGB(0x646566) forState:UIControlStateNormal];
    [like setTitle:@"TA的喜欢" forState:UIControlStateNormal];
    like.tag=200;
    [segment addSubview:like];
    [like addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _likeBtn=like;
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, segment.height-3, KMainScreenSize.width*.5, 3)];
    line.backgroundColor=UIColorFromRGB(0x24cdfd);
    [segment addSubview:line];
    _line=line;
    

    
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

-(void)click:(UIButton *)aBtn{
    
    if (aBtn.tag==100) {
        _rightView.hidden=YES;
        _leftView.hidden=NO;
        [_likeBtn setSelected:NO];
        [_releaseBtn setSelected:YES];
        _line.frame=CGRectMake(0, _releaseBtn.height-3, KMainScreenSize.width*.5, 3);
        
    }else{
        [_likeBtn setSelected:YES];
        [_releaseBtn setSelected:NO];
        _leftView.hidden=YES;
        _rightView.hidden=NO;
        _line.frame=CGRectMake(KMainScreenSize.width*.5, _releaseBtn.height-3, KMainScreenSize.width*.5, 3);
    }
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
    detail=[[UIView alloc]initWithFrame:CGRectMake(0, imgHead.bottom+5, KMainScreenSize.width, 120)];
    
    UILabel *nick=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, KMainScreenSize.width, 15)];
    nick.text = _nearInfo.strName;
    nick.textColor=[UIColor whiteColor];
    nick.textAlignment=NSTextAlignmentCenter;
    [nick setFont:XCFONT(14)];
    [detail addSubview:nick];
    
    
    UIView *status=[[UIView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-160)*.5,nick.bottom, 160, 30)];
    
    UserOperationModel *model=[[UserOperationModel alloc]init];
    model.title=@"关注";
    model.number=_nearInfo.nFocusNum;
    model.tag=100;
    
    UserOperationModel *model1=[[UserOperationModel alloc]init];
    model1.title=@"粉丝";
    model1.number=_nearInfo.nFansNum;
    model1.tag=200;
    
    
    
    NSArray *list=[NSArray arrayWithObjects:model,model1, nil];
    
    for (int i=0; i<list.count; i++) {
        UserOperationModel *obj=[list objectAtIndex:i];
        TwoTitleButton *aBtn=[[TwoTitleButton alloc]initWithFrame:CGRectMake(i*(status.width/list.count), 0, status.width/list.count, status.height) title1:obj.title title2:[NSString stringWithFormat:@"%i",obj.number]];
        aBtn.tag=obj.tag;
        [aBtn addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
        [status addSubview:aBtn];
    }
    _statusView=status;
    [detail addSubview:status];
    
    
    
//    UILabel *focus=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.20, sign.bottom+10, KMainScreenSize.width*.25, 20)];
//    focus.text=[NSString stringWithFormat:@"%d",_nearInfo.nFocusNum];
//    focus.textAlignment=NSTextAlignmentCenter;
//    focus.font=[UIFont systemFontOfSize:14];
//    [detail addSubview:focus];
//    
//    UIButton *focusTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*.30, focus.bottom+5, KMainScreenSize.width*.25, 20)];
//    [focusTitle setTitle:@"关注" forState:UIControlStateNormal];
//    [focusTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    focusTitle.titleLabel.font=[UIFont systemFontOfSize:14];
//    [focusTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
//    focusTitle.tag=100;
//    [detail addSubview:focusTitle];
    
    
//    UILabel *fans=[[UILabel alloc]initWithFrame:CGRectMake(KMainScreenSize.width*0.5, sign.bottom+10, KMainScreenSize.width*.25, 20)];
//    fans.text=[NSString stringWithFormat:@"%d",_nearInfo.nFansNum];
//    fans.textAlignment=NSTextAlignmentCenter;
//    fans.font=[UIFont systemFontOfSize:14];
//    [detail addSubview:fans];
//    
//    UIButton *fansTitle=[[UIButton alloc]initWithFrame:CGRectMake(KMainScreenSize.width*0.6, fans.bottom+5, KMainScreenSize.width*.25, 20)];
//    [fansTitle setTitle:@"粉丝" forState:UIControlStateNormal];
//    fansTitle.titleLabel.font=[UIFont systemFontOfSize:14];
//    [fansTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [fansTitle addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
//    fansTitle.tag=200;
//    [detail addSubview:fansTitle];
    
    UIView *operation=[[UIView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-160)*.5,status.bottom, 160, 30)];
    
    LeftImgButton *focusBtn=[[LeftImgButton alloc]initWithFrame:CGRectMake(0, 0, operation.width*.5-10, 25)];
    focusBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    focusBtn.layer.borderWidth=1;
    //focus.backgroundColor=[UIColor whiteColor];
    [focusBtn setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    //[focus setBackgroundColor:UIColorFromRGB(0x646566)];
    [focusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [focusBtn setImage:[UIImage imageNamed:@"my_focus"] forState:UIControlStateNormal];
    [focusBtn setTitle:[self isFocusFromFocusCode:_nearInfo.nRelation] forState:UIControlStateNormal];
    focusBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    focusBtn.tag=1000;
    [operation addSubview:focusBtn];
    [focusBtn addTarget:self action:@selector(getFocus) forControlEvents:UIControlEventTouchUpInside];
    _focusBtn=focusBtn;
    
    LeftImgButton *chat=[[LeftImgButton alloc]initWithFrame:CGRectMake(focusBtn.right+20, 0, operation.width*.5-10, 25)];
    //chat.backgroundColor=[UIColor redColor];
    chat.layer.borderColor=[UIColor whiteColor].CGColor;
    chat.layer.borderWidth=1;
    [chat setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [chat setImage:[UIImage imageNamed:@"my_chat"] forState:UIControlStateNormal];
    [chat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[chat setBackgroundColor:UIColorFromRGB(0x24cdfd)];
    [chat setTitle:@"私信" forState:UIControlStateNormal];
    chat.titleLabel.font=[UIFont systemFontOfSize:12];
    chat.tag=2000;
    [operation addSubview:chat];
    [chat addTarget:self action:@selector(getChat) forControlEvents:UIControlEventTouchUpInside];
    
    [detail addSubview:operation];
    
    UILabel *sign=[[UILabel alloc]initWithFrame:CGRectMake(0, operation.bottom+5, KMainScreenSize.width, 25)];
    sign.text=[UserInfo sharedUserInfo].strSignature;
    sign.textColor=[UIColor whiteColor];
    [sign setFont:XCFONT(14)];
    if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""])
    {
        sign.text=@"这个人很懒,什么都没有留下.";
    }
    sign.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:sign];

    
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
    NSLog(@"btnSender.tag=%li",btnSender.tag);
    switch (btnSender.tag) {
        case 100:
        {
            MyFocusViewController *focus=[[MyFocusViewController alloc]init];
            focus.hidesBottomBarWhenPushed=YES;
            focus.nUserId=[_nearInfo.strUserId intValue];
            [self.navigationController pushViewController:focus animated:YES];
        }break;
        case 200:{
            MyFansViewController *fans=[[MyFansViewController alloc]init];
            fans.nUserId=[_nearInfo.strUserId intValue];
            fans.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:fans animated:YES];
        }break;
            
        default:
            break;
    }
}

-(void)getUserInfo
{
    
}

-(void)theyDetail
{
    
}

-(void)getFocus{
    
    __weak typeof(self) weakSelf=self;
   focus = [[FocusService alloc] init];
    
    focus.httpFocus = ^(int nStatus,NSString *strMsg)
    {
        if (nStatus == 1)
        {
            [weakSelf requestRelation];
        }
        else
        {
            [weakSelf.view makeToast:strMsg];
        }
    };
    [focus requestFocus:_nearInfo.strUserId];


}
-(void)getChat{

}


-(NSString *)isFocusFromFocusCode:(NSInteger )code{
    switch (code) {
        case 10:{
            return @"已关注";
        }break;
        case 11:{
            return @"已关注";
        }break;
        case 0:{
            return @"关注";
        }break;
        case 1:{
            return @"关注";
        }break;
            
        default:
            return nil;
            break;
    }
}


@end
