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
#import "MyFansViewController.h"
#import "MyFocusViewController.h"
#import "MyButton.h"
#import "UserOperationModel.h"
#import "LeftImgButton.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_headView;
    UIView *_detailView;
    UIView *_leftView;
    UIView *_rightView;
    UIImageView *_icon;
    UILabel *_singture;
    UILabel *_nickName;
    UIButton *_likeBtn;
    UIButton *_releaseBtn;
    UIView *_line;
    UIView *_tableHeadView;
    UIView *_statusView;
    UITableView *_tableView;
}

@property (nonatomic,strong) NSArray *items;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
    [self initContentView];
    [self click:_releaseBtn];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    if ([UserInfo sharedUserInfo].strToken) {
        [self getUserInfo];
    }else{
        [self.tabBarController setSelectedIndex:0];
    }
    
}

-(void)getUserInfo
{
    MyInfoService *service=[[MyInfoService alloc]init];
    service.getMyInfoBlock=^(NSString *error){
        
        MyButton *focus=(MyButton *)[_statusView viewWithTag:100];
        [focus setValueWithNumber:[UserInfo sharedUserInfo].strFocusNum];
        
        MyButton *fans=(MyButton *)[_statusView viewWithTag:200];
        [fans setValueWithNumber:[UserInfo sharedUserInfo].strFansNum];
        
        MyButton *heart=(MyButton *)[_statusView viewWithTag:300];
        [heart setValueWithNumber:[UserInfo sharedUserInfo].strFocusNum];
        
        MyButton *like=(MyButton *)[_statusView viewWithTag:400];
        [like setValueWithNumber:[UserInfo sharedUserInfo].strFocusNum];
        
        _nickName.text=[UserInfo sharedUserInfo].strNickName;
        
        if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""]) {
            _singture.text=@"这个人很懒,什么都没有留下.";
        }else{
            _singture.text=[UserInfo sharedUserInfo].strSignature;
        }
        [_icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    };
    if (self.nUserID==0) {
        [service requestUserId:0];
    }else{
        [service requestUserId:self.nUserID];
    }
    
}

-(void)initSelfView
{
    self.title=@"我的";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initTableViewHeadView{
    UIView *detail=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 260)];
    detail.backgroundColor=[UIColor whiteColor];
    detail.layer.borderColor=[UIColor grayColor].CGColor;
    detail.layer.borderWidth=0.5;
    
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 100)];
    head.image=[UIImage imageNamed:@"headView_bg"];
    [detail addSubview:head];
    
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, head.bottom-60, 80, 80)];
    icon.layer.cornerRadius= icon.bounds.size.width/2;
    icon.layer.masksToBounds=YES;
    icon.userInteractionEnabled=YES;
    [icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myDetail:)];
    [icon addGestureRecognizer:tap];
    [detail addSubview:icon];
    _icon=icon;
    
    
    UILabel *nick=[[UILabel alloc]initWithFrame:CGRectMake(0, icon.bottom+10, KMainScreenSize.width, 20)];
    nick.text=[UserInfo sharedUserInfo].strNickName;
    nick.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:nick];
    _nickName=nick;
    
    UILabel *sign=[[UILabel alloc]initWithFrame:CGRectMake(0, nick.bottom+5, KMainScreenSize.width, 20)];
    sign.text=[UserInfo sharedUserInfo].strSignature;
    sign.textColor=[UIColor grayColor];
    sign.font=[UIFont systemFontOfSize:14];
    if ([[UserInfo sharedUserInfo].strSignature isEqualToString:@""]) {
        sign.text=@"这个人很懒,什么都没有留下.";
    }
    sign.textAlignment=NSTextAlignmentCenter;
    [detail addSubview:sign];
    _singture=sign;
    
    
    UIView *status=[[UIView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-200)*.5,_singture.bottom, 200, 40)];
    
    UserOperationModel *model=[[UserOperationModel alloc]init];
    model.title=@"关注";
    model.number=0;
    model.tag=100;
    
    UserOperationModel *model1=[[UserOperationModel alloc]init];
    model1.title=@"粉丝";
    model1.number=0;
    model1.tag=200;
    
    UserOperationModel *model2=[[UserOperationModel alloc]init];
    model2.title=@"赞";
    model2.number=0;
    model2.tag=300;
    
    UserOperationModel *model3=[[UserOperationModel alloc]init];
    model3.title=@"评论";
    model3.number=0;
    model3.tag=400;
    
    
    NSArray *list=[NSArray arrayWithObjects:model,model1,model2,model3, nil];
    
    for (int i=0; i<list.count; i++) {
        UserOperationModel *obj=[list objectAtIndex:i];
        MyButton *aBtn=[[MyButton alloc]initWithFrame:CGRectMake(i*status.width/list.count, 0, status.width/list.count, status.height)];
        [aBtn setValueWithUserOperationModel:obj];
        [aBtn addTarget:self action:@selector(gotoOther:) forControlEvents:UIControlEventTouchUpInside];
        [status addSubview:aBtn];
    }
    _statusView=status;
    [detail addSubview:status];
    
    
    UIView *operation=[[UIView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-160)*.5,_statusView.bottom, 160, 40)];
    
    LeftImgButton *focus=[[LeftImgButton alloc]initWithFrame:CGRectMake(0, 10, operation.width*.5-10, 30)];
    focus.layer.borderColor=[UIColor grayColor].CGColor;
    focus.layer.borderWidth=1;
    //focus.backgroundColor=[UIColor whiteColor];
    [focus setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    //[focus setBackgroundColor:UIColorFromRGB(0x646566)];
    [focus setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateNormal];
    [focus setImage:[UIImage imageNamed:@"my_focus"] forState:UIControlStateNormal];
    [focus setTitle:@"关注" forState:UIControlStateNormal];
    focus.titleLabel.font=[UIFont systemFontOfSize:14];
    focus.tag=1000;
    [operation addSubview:focus];
    [focus addTarget:self action:@selector(getFocus) forControlEvents:UIControlEventTouchUpInside];
    
    
    LeftImgButton *chat=[[LeftImgButton alloc]initWithFrame:CGRectMake(focus.right+20, 10, operation.width*.5-10, 30)];
    //chat.backgroundColor=[UIColor redColor];
    chat.layer.borderColor=[UIColor grayColor].CGColor;
    chat.layer.borderWidth=1;
    [chat setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [chat setImage:[UIImage imageNamed:@"my_chat"] forState:UIControlStateNormal];
    [chat setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateNormal];
    //[chat setBackgroundColor:UIColorFromRGB(0x24cdfd)];
    [chat setTitle:@"私信" forState:UIControlStateNormal];
    chat.titleLabel.font=[UIFont systemFontOfSize:14];
    chat.tag=2000;
    [operation addSubview:chat];
    [chat addTarget:self action:@selector(getChat) forControlEvents:UIControlEventTouchUpInside];
    
    [detail addSubview:operation];
    _tableHeadView=detail;
}

-(void)clickMyButton:(UIButton *)aBtn{
    NSLog(@"%s",__FUNCTION__);
}

-(void)initTableView{
    
    [self initTableViewHeadView];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.tableHeaderView=_tableHeadView;

    UIView *view=[UIView new];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
    
    [self.view addSubview:tableView];
    _tableView=tableView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.items) {
        return 10;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.items) {
        return 10;
    }else{
        return 325;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.items) {
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }else{
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *segment=[[UIView alloc]initWithFrame:CGRectMake(0, _detailView.bottom, KMainScreenSize.width, 40)];
    [self.view addSubview:segment];
    
    UIButton *release=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width*.5, 40)];
    release.backgroundColor=[UIColor whiteColor];
    [release setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [release setTitleColor:UIColorFromRGB(0x646566) forState:UIControlStateNormal];
    [release setTitle:@"我的发布" forState:UIControlStateNormal];
    release.tag=100;
    [segment addSubview:release];
    [release addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [release setSelected:YES];

    _releaseBtn=release;
    
    UIButton *like=[[UIButton alloc]initWithFrame:CGRectMake(release.right, 0, KMainScreenSize.width*.5, 40)];
    like.backgroundColor=[UIColor whiteColor];
    [like setTitleColor:UIColorFromRGB(0x24cdfd) forState:UIControlStateSelected];
    [like setTitleColor:UIColorFromRGB(0x646566) forState:UIControlStateNormal];
    [like setTitle:@"我的喜欢" forState:UIControlStateNormal];
    like.tag=200;
    [segment addSubview:like];
    [like addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _likeBtn=like;
    
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, segment.height-3, KMainScreenSize.width*.5, 3)];
    line.backgroundColor=UIColorFromRGB(0x24cdfd);
    [segment addSubview:line];
    _line=line;

    return segment;
}


-(void)getFocus{

}

-(void)getChat{

}

-(void)click:(UIButton *)aBtn{
    
    if (aBtn.tag==100) {
        [_likeBtn setSelected:NO];
        [_releaseBtn setSelected:YES];
        _line.frame=CGRectMake(0, _releaseBtn.height-3, KMainScreenSize.width*.5, 3);
        
    }else{
        [_likeBtn setSelected:YES];
        [_releaseBtn setSelected:NO];
        _line.frame=CGRectMake(KMainScreenSize.width*.5, _releaseBtn.height-3, KMainScreenSize.width*.5, 3);
    }
    
    if (self.items) {
        
    }else{
        NSArray *cells=[_tableView visibleCells];
        for (UITableViewCell *cell in cells) {
            UIView *view=[cell viewWithTag:888];
            [view removeFromSuperview];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if (_releaseBtn.selected) {
                UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0,0, KMainScreenSize.width, 325)];
                view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
                view1.tag=888;
                
                UIImageView *push=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, (view1.height-80)*.5, 80, 80)];
                push.image=[UIImage imageNamed:@"my_camera"];
                [view1 addSubview:push];
                
                UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,push.bottom-20, 280, 80)];
                text.text=@"青春的时光很短，我们也过得匆忙。我们不能让时光的飞逝慢一点，只能用镜头记录每一个美好瞬间，留作纪念";
                text.font=[UIFont systemFontOfSize:10];
                text.backgroundColor=[UIColor clearColor];
                [view1 addSubview:text];
                
                [cell addSubview:view1];
            }else{
                UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, 325)];
                view2.backgroundColor=[UIColor groupTableViewBackgroundColor];
                view2.tag=888;
                
                UIImageView *like=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, (view2.height-80)*.5, 80, 80)];
                like.image=[UIImage imageNamed:@"my_heart"];
                [view2 addSubview:like];
                
                UILabel *text1=[[UILabel alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,like.bottom, 280, 20)];
                text1.text=@"您的喜欢还是空的！";
                text1.textAlignment=NSTextAlignmentCenter;
                text1.font=[UIFont systemFontOfSize:10];
                text1.backgroundColor=[UIColor clearColor];
                [view2 addSubview:text1];
                [cell addSubview:view2];
                
            }

        }
        
      
    }
    
    

}

-(void)initContentView{
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0,0, KMainScreenSize.width, self.view.frame.size.height)];
    view1.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIImageView *push=[[UIImageView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-80)*.5, (view1.height-80)*.5, 80, 80)];
    push.image=[UIImage imageNamed:@"my_camera"];
    [view1 addSubview:push];
    
    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake((KMainScreenSize.width-280)*.5,push.bottom-20, 280, 80)];
    text.text=@"青春的时光很短，我们也过得匆忙。我们不能让时光的飞逝慢一点，只能用镜头记录每一个美好瞬间，留作纪念";
    text.font=[UIFont systemFontOfSize:10];
    text.backgroundColor=[UIColor clearColor];
    [view1 addSubview:text];
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, self.view.frame.size.height)];
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
    
    
}

-(void)gotoOther:(UIButton *)aBtn{
    switch (aBtn.tag) {
        case 100:
        {
            
            MyFocusViewController *other=[[MyFocusViewController alloc]init];
            other.hidesBottomBarWhenPushed=YES;
            other.nUserId=[[UserInfo sharedUserInfo].strUserId intValue];
            [self.navigationController pushViewController:other animated:YES];
        }break;
        case 200:{
            MyFansViewController *other=[[MyFansViewController alloc]init];
            other.hidesBottomBarWhenPushed=YES;
            other.nUserId=[[UserInfo sharedUserInfo].strUserId intValue];
            [self.navigationController pushViewController:other animated:YES];
            
        }break;
            
        default:
            break;
    }
}

-(void)myDetail:(UITapGestureRecognizer *)tap{
    
    if ([UserInfo sharedUserInfo].strToken) {
        if (self.nUserID!=0) {
            return ;
        }
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
