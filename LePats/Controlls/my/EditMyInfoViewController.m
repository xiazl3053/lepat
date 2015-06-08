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
#import "HttpUploadManager.h"
#import "Toast+UIView.h"
#import "SexButton.h"

@interface EditMyInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITextField *_nickName;
    UITextView *_signTure;
    int _sex;
    UITextField *_brithDay;
    UIDatePicker *_datePickerView;
    UIButton *_male;
    UIButton *_female;
    UIImage *_iconImg;
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
    [self setRightHidden:NO];
    [self setRightTitle:@"完成"];
    
    __block EditMyInfoViewController *__self = self;
    [self addRightEvent:^(id sender)
     {
         
         switch (__self.editType) {
             case MYInfoEdit_TYPE_NickName:
             {
                 [UserInfo sharedUserInfo].strNickName=__self->_nickName.text;
                 [__self requestEditNickName];
             }break;
             case MYInfoEdit_TYPE_Signture:
             {
                 [UserInfo sharedUserInfo].strSignature=__self->_signTure.text;
                 [__self requestEditSingture];
             }break;
             case MYInfoEdit_TYPE_Sex:
             {
                 [UserInfo sharedUserInfo].nSex=__self->_sex;
                 [__self requestEditSex];
             }break;
             case MYInfoEdit_TYPE_Brithday:
             {
                 [UserInfo sharedUserInfo].strBirthday=__self->_brithDay.text;
                 [__self requestEditBrithday];
             }break;
             case MYInfoEdit_TYPE_Icon:
             {
                 [__self updateImage:__self->_iconImg];
             }break;
                 
             default:
                 break;
         }
         
     }];
}

-(void)requestEditSex{
    __block EditMyInfoViewController *__self = self;
    EditMyInfoService *service=[[EditMyInfoService alloc]init];
    service.editMyInfoBlock=^(NSString *error){
        if (error) {
            [__self.view makeToast:error];
        }else{
            [__self.view makeToast:@"更改性别成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    [service requestEditSex];
}

-(void)requestEditSingture{
    if ([UserInfo sharedUserInfo].strSignature.length>46) {
        [self.view makeToast:@"签名过长"];
        return ;
    }
    __block EditMyInfoViewController *__self = self;
    EditMyInfoService *service=[[EditMyInfoService alloc]init];
    service.editMyInfoBlock=^(NSString *error){
        if (error) {
             [__self.view makeToast:error];
        }else{
            
            [__self.view makeToast:@"更改签名成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    [service requestEditSingture];
}

-(void)requestEditBrithday{
    __block EditMyInfoViewController *__self = self;
    EditMyInfoService *service=[[EditMyInfoService alloc]init];
    service.editMyInfoBlock=^(NSString *error){
        if (error) {
            [__self.view makeToast:error];
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    [service requestEditBrithday];
}

-(void)requestEditNickName{
    __block EditMyInfoViewController *__self = self;
    EditMyInfoService *service=[[EditMyInfoService alloc]init];
    service.editMyInfoBlock=^(NSString *error){
        if (error) {
             [__self.view makeToast:error];
        }else{
            [__self.view makeToast:@"更改昵称成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    [service requestEditNickName];
}

-(void)initContentView{
    
    self.view.backgroundColor=UIColorFromRGB(0xf5f6f7);
    switch (self.editType) {
        case MYInfoEdit_TYPE_NickName:
        {
            self.title = @"昵称";
            [self initNickView];
        }break;
        case MYInfoEdit_TYPE_Signture:
        {
            self.title = @"签名";
            [self initSigntureView];
        }break;
        case MYInfoEdit_TYPE_Sex:
        {
            self.title=@"性别";
            [self initSexView];
        }break;
        case MYInfoEdit_TYPE_Brithday:{
            self.title=@"出生年月";
            [self initBrithdayView];
        }break;
        case MYInfoEdit_TYPE_Icon:{
            self.title=@"头像";
            [self initIconView];
        }break;
            
        default:
            break;
    }
}

-(void)initNickView{
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(0, [self barSize].height+20, KMainScreenSize.width, 40)];
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field.font=[UIFont systemFontOfSize:14];
    field.layer.borderColor=UIColorFromRGB(0xcbcccd).CGColor;
    field.layer.borderWidth=.5;
    field.text=[UserInfo sharedUserInfo].strNickName;
    [field becomeFirstResponder];
    [self.view addSubview:field];
    _nickName=field;
}

-(void)initSigntureView{
    
    UITextView *field=[[UITextView alloc]initWithFrame:CGRectMake(10, [self barSize].height+20, KMainScreenSize.width-20, 200)];
    field.layer.borderColor=UIColorFromRGB(0xcbcccd).CGColor;
    field.layer.borderWidth=.5;
    field.text=[UserInfo sharedUserInfo].strSignature;
    [field becomeFirstResponder];
    [self.view addSubview:field];
    
    UILabel *number=[[UILabel alloc]initWithFrame:CGRectMake(field.width-20, field.bottom-20, 20, 20)];
    number.text=@"46";
    number.textAlignment=NSTextAlignmentRight;
    number.font=[UIFont systemFontOfSize:14];
    number.textColor=[UIColor grayColor];
    [self.view addSubview:number];
    _signTure=field;
    
}

-(void)initSexView{
    
    UIView *topLine=[[UIView alloc]initWithFrame:CGRectMake(0, [self barSize].height+20,KMainScreenSize.width , 0.5)];
    topLine.backgroundColor=UIColorFromRGB(0xcbcccd);
    [self.view addSubview:topLine];
    
    SexButton *male=[[SexButton alloc]initWithFrame:CGRectMake(0, topLine.bottom+0.5, KMainScreenSize.width, 40)];
    [male setTitle:@"男" forState:UIControlStateNormal];
    male.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    male.layer.borderWidth=1.0;
    [male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [male setImage:[UIImage imageNamed:@"mydetail_select"] forState:UIControlStateSelected];
    male.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    male.tag=100;
    [male setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [male addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:male];
    _male=male;
    
    UIView *centerLine=[[UIView alloc]initWithFrame:CGRectMake(0, male.bottom,KMainScreenSize.width , 0.5)];
    centerLine.backgroundColor=UIColorFromRGB(0xcbcccd);
    [self.view addSubview:centerLine];
    
    SexButton *female=[[SexButton alloc]initWithFrame:CGRectMake(0, centerLine.bottom+0.5, KMainScreenSize.width, 40)];
    female.tag=200;
    female.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [female setTitle:@"女" forState:UIControlStateNormal];
    [female setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [female setImage:[UIImage imageNamed:@"mydetail_select"] forState:UIControlStateSelected];
    [female addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:female];
    _female=female;
    
    UIView *bottomLine=[[UIView alloc]initWithFrame:CGRectMake(0, female.bottom+0.5,KMainScreenSize.width , 0.5)];
    bottomLine.backgroundColor=UIColorFromRGB(0xcbcccd);
    [self.view addSubview:bottomLine];
    
    if ([UserInfo sharedUserInfo].nSex==0) {
        [_male setSelected:YES];
        [_female setSelected:NO];
    }else{
        [_female setSelected:YES];
        [_male setSelected:NO];
    }
}

-(void)initBrithdayView{
    
    UIDatePicker *picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    [picker setDate:[NSDate date] animated:YES];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [picker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventValueChanged];
    _datePickerView=picker;
    
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(0, [self barSize].height, KMainScreenSize.width, 40)];
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field.inputView=_datePickerView;
    [self.view addSubview:field];
    _brithDay=field;
    
}

-(void)initIconView{
    UIButton *male=[[UIButton alloc]initWithFrame:CGRectMake(0, [self barSize].height, KMainScreenSize.width, 40)];
    male.tag=100;
    [male setTitle:@"拍照" forState:UIControlStateNormal];
    [male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [male addTarget:self action:@selector(initCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:male];
    
    UIButton *female=[[UIButton alloc]initWithFrame:CGRectMake(0, male.bottom, KMainScreenSize.width, 40)];
    female.tag=200;
    [female setTitle:@"本地相册" forState:UIControlStateNormal];
    [female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [female addTarget:self action:@selector(initPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:female];
}

-(void)dataPickerValueChange:(UIDatePicker *)picker{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:picker.date];
    _brithDay.text=dateString;
    NSLog(@"%@",dateString);
}

-(void)changeSex:(UIButton *)aBtn{
    
    if (aBtn.tag==100) {
        [_male setSelected:YES];
        [_female setSelected:NO];
        _sex=0;
    }else{
        [_male setSelected:NO];
        [_female setSelected:YES];
        _sex=1;
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

//点击相册中的图片后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // NSLog(@"image=%@",[info objectForKey:UIImagePickerControllerEditedImage]);
    //[self updateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    _iconImg=[info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)updateImage:(UIImage *)img{
    HttpUploadManager *upload=[[HttpUploadManager alloc]init];
    upload.upDatePersonIconBlock=^(NSString *error){
        if (error) {
            [self.view makeToast:error];
        }else{
            [self.view makeToast:@"上传图片成功"];
        }
    };
    [upload uploadPerson:img];
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
