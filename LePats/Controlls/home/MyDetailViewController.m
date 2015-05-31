//
//  myDetailViewController.m
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyDetailViewController.h"
#import "HomeItemModel.h"
#import "MyInfoService.h"
#import "MyDetailTableViewCell.h"
#import "UserInfo.h"
#import "editmyinfoViewController.h"

@interface MyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_icon;
}
@property (nonatomic,strong) NSMutableArray *itemList;
@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initParams];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    [self getUserInfo];
    [self initData];

}

-(void)getUserInfo{
    MyInfoService *service=[[MyInfoService alloc]init];
    service.getMyInfoBlock=^(NSString *error){
        
        [self setImageInfo:[UserInfo sharedUserInfo].strUserIcon];
    };
    [service requestUserId:0];
}

-(void)initData{
    
    UserInfo *user=[UserInfo sharedUserInfo];
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:@"头像" forKey:@"title"];
    [dic setValue:@"101" forKey:@"tag"];
    [dic setValue:user.strUserIcon forKey:@"content"];
    
    NSMutableDictionary *dic1=[NSMutableDictionary dictionary];
    [dic1 setValue:@"账号" forKey:@"title"];
    [dic1 setValue:user.strMobile forKey:@"content"];
    
    NSMutableDictionary *dic2=[NSMutableDictionary dictionary];
    [dic2 setValue:@"昵称" forKey:@"title"];
    [dic2 setValue:@"103" forKey:@"tag"];
    [dic2 setValue:user.strNickName forKey:@"content"];
    
    NSMutableDictionary *dic3=[NSMutableDictionary dictionary];
    [dic3 setValue:@"性别" forKey:@"title"];
    [dic3 setValue:@"104" forKey:@"tag"];
    if (user.nSex==0) {
        [dic3 setValue:@"男" forKey:@"content"];
    }else{
        [dic3 setValue:@"女" forKey:@"content"];
    }
    
    NSMutableDictionary *dic4=[NSMutableDictionary dictionary];
    [dic4 setValue:@"出生年月" forKey:@"title"];
    [dic4 setValue:@"105" forKey:@"tag"];
    [dic4 setValue:user.strBirthday forKey:@"content"];
    
    NSMutableArray *section=[NSMutableArray array];
    [section addObject:dic];
    [section addObject:dic1];
    [section addObject:dic2];
    [section addObject:dic3];
    [section addObject:dic4];
    
    NSMutableDictionary *dic5=[NSMutableDictionary dictionary];
    [dic5 setValue:@"绑定手机" forKey:@"title"];
    [dic5 setValue:user.strMobile forKey:@"content"];
    
    NSMutableDictionary *dic6=[NSMutableDictionary dictionary];
    [dic6 setValue:@"登陆密码" forKey:@"title"];
    [dic6 setValue:@"" forKey:@"content"];
    
    NSMutableDictionary *dic7=[NSMutableDictionary dictionary];
    [dic7 setValue:@"个性签名" forKey:@"title"];
    [dic7 setValue:@"108" forKey:@"tag"];
    [dic7 setValue:user.strSignature forKey:@"content"];
    
    NSMutableDictionary *dic8=[NSMutableDictionary dictionary];
    [dic8 setValue:@"更换背景" forKey:@"title"];
    [dic8 setValue:@" " forKey:@"content"];
    
    NSMutableArray *section1=[NSMutableArray array];
    [section1 addObject:dic5];
    [section1 addObject:dic6];
    
    NSMutableArray *section2=[NSMutableArray array];
    [section2 addObject:dic7];
    [section2 addObject:dic8];
    
    self.itemList=[NSMutableArray array];
    [self.itemList addObject:section];
    [self.itemList addObject:section1];
    [self.itemList addObject:section2];

}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
}

-(void)initSelfView{
    self.title=@"我的信息";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(void)initTableView{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, [self barSize].height, KMainScreenSize.width, KMainScreenSize.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
    //1.设置tableview清除多余的分割线
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:line];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"MyDetailCell";
    MyDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[MyDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    NSArray *rows=[self.itemList objectAtIndex:indexPath.section];
    NSDictionary *dic=[rows objectAtIndex:indexPath.row];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UIImageView *icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left_icon_noraml"]];
            icon.frame=CGRectMake(KMainScreenSize.width-80, 5, 50, 50);
            _icon=icon;
            [cell addSubview:icon];
        }
    }
    [cell setValueWithNSDictionay:dic];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.itemList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rows=[self.itemList objectAtIndex:section];
    return rows.count;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *rows=[self.itemList objectAtIndex:indexPath.section];
    NSDictionary *dic=[rows objectAtIndex:indexPath.row];
    NSInteger tag=[[dic objectForKey:@"tag"]intValue];
    switch (tag) {
        case 101:
        {
            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            edit.editType=MYInfoEdit_TYPE_Icon;
            [self.navigationController pushViewController:edit animated:YES];
        }break;
        case 103:
        {
            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            edit.editType=MYInfoEdit_TYPE_NickName;
            [self.navigationController pushViewController:edit animated:YES];
        }break;
        case 104:
        {
            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            edit.editType=MYInfoEdit_TYPE_Sex;
            [self.navigationController pushViewController:edit animated:YES];
        }break;
        case 105:
        {
            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            edit.editType=MYInfoEdit_TYPE_Brithday;
            [self.navigationController pushViewController:edit animated:YES];
        }break;
        case 108:{
            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            edit.editType=MYInfoEdit_TYPE_Signture;
            [self.navigationController pushViewController:edit animated:YES];
        }break;
            
        default:
            break;
    }
}

-(void)setImageInfo:(NSString *)strImage
{
    if ([strImage isEqualToString:@""]) {
        return ;
    }
    __block NSString *__strImg = strImage;
    __weak MyDetailViewController *__self = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *imgDest = nil;
        NSURL *url = [NSURL URLWithString:__strImg];
        NSData *responseData = [NSData dataWithContentsOfURL:url];
        imgDest = [UIImage imageWithData:responseData];
        if (imgDest)
        {
            __strong UIImage *__imageDest = imgDest;
            __strong MyDetailViewController *__strongSelf = __self;
            dispatch_async(dispatch_get_main_queue(), ^{
                [__strongSelf thread_setImgView:__imageDest];
            });
        }
    });
}

-(void)thread_setImgView:(UIImage *)image
{
    _icon.image = image;
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