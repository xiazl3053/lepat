//
//  BaseViewController.m
//  LePats
//
//  Created by admin on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Extension.h"

@interface BaseViewController ()
{
    UILabel *lblTitle;
    UIButton *back;
    UIButton *btnRight;
}
@end

@implementation BaseViewController


-(void)viewWillAppear:(BOOL)animated{
    //隐藏标题栏
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
}

-(void)setLeftHidden:(BOOL)bHidden
{
    back.hidden = YES;
}

-(CGSize)barSize
{
     UIView *bgView = [self.view viewWithTag:10001];
    return bgView.size;
}

-(void)initNavigationBar
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    bgView.backgroundColor=RGB(253, 252, 250);
    
    back=[[UIButton alloc] initWithFrame:CGRectMake(0 , 20 , 44, 44)];
    [back setImage:[UIImage imageNamed:@"retrun"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(popviewcontroller) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:back];
    
    lblTitle = [[UILabel alloc] initWithFrame:Rect(50, 30,self.view.frame.size.width-100, 20)];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setFont:XCFONT(16)];
    [lblTitle setTextColor:RGB(51,51,51)];
    
    [bgView addSubview:lblTitle];
    
    UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0,63,self.view.width,0.5)];
    sLine1.backgroundColor = [UIColor colorWithRed:227/255.0
                                             green:227/255.0
                                              blue:227/255.0
                                             alpha:1.0];
    UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0,63.5,self.view.width, 0.5)] ;
    sLine2.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:sLine1];
    [bgView addSubview:sLine2];
    bgView.tag = 10001;
    [self.view addSubview:bgView];
}

-(void)setTitle:(NSString *)title
{
    lblTitle.text = title;
}


-(void)popviewcontroller
{
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightHidden:(BOOL)bHidden
{
    if (!bHidden)
    {
        btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *bgView = [self.view viewWithTag:10001];
        btnRight.frame = Rect(self.view.width-60, 30, 66, 20);
        [btnRight setTitleColor:RGB(51,51,51) forState:UIControlStateNormal];
        btnRight.titleLabel.font = XCFONT(16);
        [bgView addSubview:btnRight];
    }
}

-(void)setRightTitle:(NSString *)strTitle
{
    [btnRight setTitle:strTitle forState:UIControlStateNormal];
}


-(void)addRightEvent:(void (^)(id sender))handler
{
    [btnRight bk_addEventHandler:handler forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRightImg:(NSString *)strNor high:(NSString *)strHigh select:(NSString *)strSelect
{
    [btnRight setImage:[UIImage imageNamed:strNor] forState:UIControlStateNormal];
    [btnRight setImage:[UIImage imageNamed:strHigh] forState:UIControlStateHighlighted];
    [btnRight setImage:[UIImage imageNamed:strSelect] forState:UIControlStateSelected];
}

-(void)setRightRect:(CGRect)frame
{
    btnRight.frame = frame;
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
