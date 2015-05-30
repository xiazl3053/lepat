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

@interface EditMyInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITextField *_nickName;
    UITextView *_signTure;
    int _sex;
    UITextField *_brithDay;
    UIDatePicker *_datePickerView;
    UIButton *_male;
    UIButton *_female;
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
             case MYInfoEdit_TYPE_Brithday:
             {
                 [UserInfo sharedUserInfo].strBirthday=__self->_brithDay.text;
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
    [male setTitle:@"男" forState:UIControlStateNormal];
    [male setTitleColor:[UIColor redColor]  forState:UIControlStateSelected];
    [male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    male.tag=100;
    [male addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:male];
    _male=male;
    
    UIButton *female=[[UIButton alloc]initWithFrame:CGRectMake(0, male.bottom, KMainScreenSize.width, 40)];
    female.tag=200;
    [female setTitle:@"女" forState:UIControlStateNormal];
    [female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [female setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [female addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:female];
    _female=female;
}

-(void)initBrithdayView{
    
    UIDatePicker *picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    [picker setDate:[NSDate date] animated:YES];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [picker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventValueChanged];
    _datePickerView=picker;
    
    UITextField *field=[[UITextField alloc]initWithFrame:CGRectMake(0, 44, KMainScreenSize.width, 40)];
    field.backgroundColor=[UIColor groupTableViewBackgroundColor];
    field.inputView=_datePickerView;
    [self.view addSubview:field];
    _brithDay=field;

}

-(void)initIconView{
    UIButton *male=[[UIButton alloc]initWithFrame:CGRectMake(0, 44, KMainScreenSize.width, 40)];
    male.tag=100;
    [male setTitle:@"拍照" forState:UIControlStateNormal];
    [male addTarget:self action:@selector(initCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:male];
    
    UIButton *female=[[UIButton alloc]initWithFrame:CGRectMake(0, male.bottom, KMainScreenSize.width, 40)];
    female.tag=200;
    [female setTitle:@"本地相册" forState:UIControlStateNormal];
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
        _sex=1;
    }else{
        [_male setSelected:NO];
        [_female setSelected:YES];
        _sex=0;
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
    [self updateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)updateImage:(UIImage *)img{
    HttpUploadManager *upload=[[HttpUploadManager alloc]init];
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
