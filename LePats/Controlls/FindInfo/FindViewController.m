//
//  FindViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-23.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FindViewController.h"
#import "FindService.h"
#import "UIView+Extension.h"
#import "FriendListViewController.h"


@interface FindViewController()<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation FindViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"发现";
    [self setLeftHidden:YES];
    [self.view setBackgroundColor:RGB(240, 240, 240)];
    [self initView];
}

-(void)initView
{
//    UITextField *txtFind = [[UITextField alloc] initWithFrame:Rect(0, 80,self.view.width,44)];
//    [txtFind setBackgroundColor:RGB(255,255,255)];
//    [self.view addSubview:txtFind];
//    
//    UIView *viewFind = [[UIView alloc] initWithFrame:Rect(0, 0, 44, 44)];
//    UIImageView *imgFind = [[UIImageView alloc] initWithFrame:Rect(22, 11, 22, 22)];
//    [imgFind setImage:[UIImage imageNamed:@"login_pwd_img"]];
//    [viewFind addSubview:imgFind];
//    
//    txtFind.leftView = viewFind;
//    txtFind.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    txtFind.leftViewMode = UITextFieldViewModeAlways;
//    [txtFind setTextColor:RGB(15, 173, 225)];
//    [txtFind setText:@"附近鱼友"];
//    [txtFind setFont:XCFONT(12)];
//    [txtFind resignFirstResponder];
//    
//    UITextField *txtScan = [[UITextField alloc] initWithFrame:Rect(0, 150, self.view.width, 44)];
//    [txtScan setBackgroundColor:RGB(255,255,255)];
//    [self.view addSubview:txtScan];
//    
//    UIView *viewScan = [[UIView alloc] initWithFrame:Rect(0, 0, 44, 44)];
//    UIImageView *imgScan = [[UIImageView alloc] initWithFrame:Rect(22, 11, 22, 22)];
//    [imgScan setImage:[UIImage imageNamed:@"login_user_img"]];
//    [viewScan addSubview:imgScan];
//    txtScan.leftView = viewScan;
//    txtScan.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    txtScan.leftViewMode = UITextFieldViewModeAlways;
//    [txtScan setTextColor:RGB(15, 173, 225)];
//    [txtScan setText:@"扫一扫"];
//    [txtScan setFont:XCFONT(12)];
    
    _tableView = [[UITableView alloc] initWithFrame:Rect(0, 44,self.view.width, self.view.height-44) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setBackgroundColor:RGB(240, 240, 240)];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIdentifier = @"FindViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
    }
    if (indexPath.section==0)
    {
        cell.imageView.image = [UIImage imageNamed:@"login_user_img"];
        cell.textLabel.text = @"寻找鱼友";
    }
    else if(indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"login_pwd_img"];
        cell.textLabel.text = @"扫一扫";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        FriendListViewController *friendView = [[FriendListViewController alloc] init];
        [self.navigationController pushViewController:friendView animated:YES];
    }
}


@end
