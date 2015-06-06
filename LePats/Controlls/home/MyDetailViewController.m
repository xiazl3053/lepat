//
//  myDetailViewController.m
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyDetailViewController.h"
#import "HomeItemModel.h"
#import "LoginUserDB.h"
#import "MyInfoService.h"
#import "MyDetailTableViewCell.h"
#import "UserInfo.h"
#import "HttpUploadManager.h"
#import "editmyinfoViewController.h"
#import "Toast+UIView.h"
#import "ProgressHUD.h"
#import "UserModel.h"
#import "AccessoryToolView.h"
#import "EditMyInfoService.h"
@interface MyDetailViewController ()<UITableViewDataSource,UITableViewDelegate,
                    UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

{
    UIImageView *_icon;
    UITableView *_tableView;
    UIDatePicker *_datePickerView;
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
    
    //    myFansService *fans=[[myFansService alloc]init];
    //    [fans requestPetInfo:100];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self initParams];
}

-(void)getUserInfo{
    MyInfoService *service=[[MyInfoService alloc]init];
    __weak UIImageView *__icon = _icon;
    __weak UITableView *__tableView = _tableView;
    service.getMyInfoBlock=^(NSString *error){
        [__icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
        [__tableView reloadData];
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
    
    NSMutableArray *section3=[NSMutableArray array];
    
    NSMutableDictionary *dic9=[NSMutableDictionary dictionary];
    
    [section3 addObject:dic9];
    
    self.itemList=[NSMutableArray array];
    [self.itemList addObject:section];
    [self.itemList addObject:section1];
    [self.itemList addObject:section2];
    [self.itemList addObject:section3];
    
    [_tableView reloadData];
    
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
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, [self barSize].height, KMainScreenSize.width, KMainScreenSize.height- [self barSize].height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    _tableView=tableView;
    
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
            UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(KMainScreenSize.width-60, 5, 50, 50)];
            [icon sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
            _icon=icon;
            cell.content.hidden=YES;
            cell.indicate.hidden=YES;
            cell.title.frame=CGRectMake(30, 10, 200, 44);
            [cell addSubview:icon];
        }
        
        if (indexPath.row==1) {
            cell.indicate.hidden=YES;
        }
    }
    
    if (indexPath.section==3)
    {
        cell.indicate.hidden=YES;
        UIButton *logout=[[UIButton alloc] initWithFrame:CGRectMake(10, 0, self.view.width-20, cell.height)];
        [logout setTitle:@"退出" forState:UIControlStateNormal];
        [logout addTarget:self action:@selector(logoutView) forControlEvents:UIControlEventTouchUpInside];
        [logout setBackgroundColor:RGB(15,173,225)];
        [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logout.layer setMasksToBounds:YES];
        logout.layer.cornerRadius = 3.0f;
        [cell addSubview:logout];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    }
    [cell setValueWithNSDictionay:dic];
    return cell;
}

-(void)logoutView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否注销?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 1050;
    [alert show];
}

-(void)logout
{
    UserModel *uDl = [[UserModel alloc] init];
    uDl.strUser = [UserInfo sharedUserInfo].strMobile;
    uDl.strPwd = [UserInfo sharedUserInfo].strPassword;
    uDl.strToken = [UserInfo sharedUserInfo].strToken;
    uDl.nLogin = 0;
    [LoginUserDB updateSaveInfo:uDl];
    [UserInfo sharedUserInfo].strToken=nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:KUserLogout object:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1050) {
        switch (buttonIndex) {
            case 1:
            {
                [self logout];
            }
                break;
            default:
                break;
        }
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.itemList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else{
            return 44;
        }
    }else{
        return 44;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rows=[self.itemList objectAtIndex:section];
    return rows.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView endEditing:YES];
    NSArray *rows=[self.itemList objectAtIndex:indexPath.section];
    NSDictionary *dic=[rows objectAtIndex:indexPath.row];
    NSInteger tag=[[dic objectForKey:@"tag"]intValue];
    switch (tag) {
        case 101:
        {
            //            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
            //            edit.editType=MYInfoEdit_TYPE_Icon;
            //            [self.navigationController pushViewController:edit animated:YES];
            [self addIcon:nil];
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
//            EditMyInfoViewController *edit=[[EditMyInfoViewController alloc]init];
//            edit.editType=MYInfoEdit_TYPE_Brithday;
//            [self.navigationController pushViewController:edit animated:YES];
            
            UIDatePicker *picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
            [picker setDate:[NSDate date] animated:YES];
            [picker setDatePickerMode:UIDatePickerModeDate];
            _datePickerView=picker;
            //[picker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventValueChanged];
            MyDetailTableViewCell *cell=(MyDetailTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.content.userInteractionEnabled=YES;
            AccessoryToolView *accessory=[[AccessoryToolView alloc]init];
            accessory.accessoryToolViewClickBlock=^(NSInteger index){
                [_tableView endEditing:YES];
                if (index==1) {
                    NSLog(@"取消");
                }else{
                    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
                    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                    fmt.dateFormat = @"yyyy-MM-dd";
                    NSString* dateString = [fmt stringFromDate:_datePickerView.date];
                    cell.content.text=dateString;
                    [UserInfo sharedUserInfo].strBirthday=dateString;
                    [self requestEditBrithDay];
                    NSLog(@"完成");
                }
            };
            cell.content.inputAccessoryView=accessory;
            cell.content.inputView=picker;
            [cell.content becomeFirstResponder];
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

-(void)requestEditBrithDay{
    __block MyDetailViewController *__self = self;
    EditMyInfoService *service=[[EditMyInfoService alloc]init];
    service.editMyInfoBlock=^(NSString *error){
        if (error) {
            [__self.view makeToast:error];
        }else{
            [__self.view makeToast:@"更改出生年月成功"];
        }
    };
    [service requestEditBrithday];
}

-(void)dataPickerValueChange:(UIDatePicker *)picker{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:picker.date];
    //_pet.strBirthday=dateString;
    //_dateCell.content.text=dateString;
    NSLog(@"%@",dateString);
}


-(void)addIcon:(UIButton *)aBtn{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"本地相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex=%li",buttonIndex);
    switch (buttonIndex) {
        case 0:{
            [self initCamera];
        }break;
        case 1:{
            [self initPhotoLibrary];
        }break;
        default:
            break;
    }
}
-(void)initCamera{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:^{
            
        }];//进入照相界面
    }else{
        NSLog(@"相机不可用");
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    
    
}

-(void)initPhotoLibrary{
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:^{
        
    }];
    
}

-(void)updateImage:(UIImage *)img{
    [ProgressHUD show:@"正在上传头像..."];
    HttpUploadManager *upload=[[HttpUploadManager alloc]init];
    upload.upDatePersonIconBlock=^(NSString *error){
        [ProgressHUD dismiss];
        if (error) {
            [self.view makeToast:@"上传图片失败"];
        }else{
            [self getUserInfo];
            [self.view makeToast:@"上传图片成功"];
        }
    };
    [upload uploadPerson:img];
}

//点击相册中的图片后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"image=%@",[info objectForKey:UIImagePickerControllerEditedImage]);
    [self updateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"cancel=%@",picker);
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
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