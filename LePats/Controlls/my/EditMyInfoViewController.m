//
//  EditNickViewController.m
//  LePats
//
//  Created by admin on 15/5/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "EditMyInfoViewController.h"
#import "EditMyInfoService.h"
#import "UserInfo.h"

@interface EditMyInfoViewController (){
    UITextField *_nickName;
    UITextView *_signTure;
    NSInteger _sex;
}

@end

@implementation EditMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initViews{
    [self initSelfView];
    [self initContentView];

}

-(void)initSelfView{
    self.title = @"昵称";
    [self setRightHidden:NO];
    [self setRightTitle:@"完成"];
    __block EditMyInfoViewController *__self = self;
    [self addRightEvent:^(id sender)
     {
         EditMyInfoService *service=[[EditMyInfoService alloc]init];
         switch (__self.editType) {
             case MYInfoEdit_TYPE_NickName:
             {
                 [UserInfo sharedUserInfo].strNickName=__self->_nickName.text;
             }break;
             case MYInfoEdit_TYPE_Signture:
             {
                 [UserInfo sharedUserInfo].strSignature=__self->_signTure.text;
             }break;
             case MYInfoEdit_TYPE_Sex:
             {
                 [UserInfo sharedUserInfo].nSex=__self->_sex;
             }break;
                 
             default:
                 break;
         }
         service.editMyInfoBlock=^(NSString *error){
             if (error) {
                 
             }else{
                 [__self.navigationController popViewControllerAnimated:YES];
             }
         };
         [service requestEditMyInfo];
     }];
}

-(void)initContentView{
    switch (self.editType) {
        case MYInfoEdit_TYPE_NickName:
        {
            [self initNickView];
        }break;
        case MYInfoEdit_TYPE_Signture:
        {
            [self initSigntureView];
        }break;
        case MYInfoEdit_TYPE_Sex:
        {
            [self initSexView];
        }break;
            
        default:
            break;
    }
}

-(void)initNickView{
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(0, 44, KMainScreenSize.width, 40)];
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:field];
    _nickName=field;
}

-(void)initSigntureView{
    
    UITextView *field=[[UITextView alloc]initWithFrame:CGRectMake(0, 44, KMainScreenSize.width, 160)];
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:field];
    _signTure=field;

}

-(void)initSexView{
    UIButton *male=[[UIButton alloc]initWithFrame:CGRectMake(0, 44, KMainScreenSize.width, 40)];
    male.backgroundColor=[UIColor redColor];
    male.tag=100;
    [male addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:male];
    
    UIButton *female=[[UIButton alloc]initWithFrame:CGRectMake(0, male.bottom, KMainScreenSize.width, 40)];
    female.tag=200;
    female.backgroundColor=[UIColor greenColor];
    [female addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:female];
}

-(void)changeSex:(UIButton *)aBtn{
    if (aBtn.tag==100) {
        _sex=1;
    }else{
        _sex=0;
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
