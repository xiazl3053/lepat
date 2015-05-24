//
//  MyPetsViewController.m
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AddPetViewController.h"
#import "LePetInfo.h"
#import "AddPetService.h"
#import "HttpUploadManager.h"
#import "AddPetCellTableViewCell.h"
#import "PetInfoService.h"


@interface AddPetViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    LePetInfo *_pet;
    UITableView *_tableView;
}

@end

@implementation AddPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    [self initData];
    if (self.type==PetType_EDIT) {
        [self queryPet];
    }
}

-(void)initData{
    LePetInfo *pet=[[LePetInfo alloc]init];
    pet.strName=@"啊黑";
    pet.strBirthday=@"5";
    pet.nSex=1;
    pet.strDescription=@"漂亮的小宝贝";
    pet.nSortId=0;
    _pet=pet;
    
}

-(void)queryPet{
    PetInfoService *pet=[[PetInfoService alloc]init];
    pet.petInfoBlock=^(NSString *error,NSDictionary *dic){
        if (error) {
            
        }else{
            _pet=[[LePetInfo alloc]initWithNSDictionary:[dic objectForKey:@"pet"]];
            self.title=_pet.strName;
            [_tableView reloadData];
        }
    };
    [pet requestPetInfo:56];
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
    [self submitPetInfoView];
}

-(void)initSelfView{
    self.title=@"添加宠物";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

-(void)submitPetInfoView{
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)*.5, self.view.frame.size.height-80, 200, 40)];
    submit.backgroundColor=[UIColor blueColor];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

-(void)submit{
    LePetInfo *pet=[[LePetInfo alloc]init];
    pet.strName=@"黄黄";
    pet.strBirthday=@"2015-03-03";
    pet.nSex=0;
    pet.strDescription=@"小小";
    pet.nSortId=3;
    
    AddPetService *service=[[AddPetService alloc]init];
    [service requestAddPet:pet];
}

-(void)initTableView{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 5*44+100) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"ADDPETCELL";
    AddPetCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[AddPetCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (self.type) {
        case PetType_ADD:{
            switch (indexPath.row) {
                case 0:
                {
                    cell.title.text=@"宠物昵称:";
                    //cell.detailTextLabel.text=_pet.strName;
                }break;
                case 1:
                {
                    cell.title.text=@"宠物类型:";
                    //cell.detailTextLabel.text=[NSString stringWithFormat:@"%i",_pet.nSortId];
                }break;
                case 2:
                {
                    cell.title.text=@"宠物年龄:";
                    //cell.detailTextLabel.text=_pet.strBirthday;
                }break;
                case 3:
                {
                    cell.title.text=@"宠物性别:";
                    //cell.detailTextLabel.text=[NSString stringWithFormat:@"%i",_pet.nSex];
                    ;
                }break;
                case 4:
                {
                    cell.title.text=@"宠物描述:";
                    //cell.detailTextLabel.text=_pet.strDescription;
                }break;
                    
                default:
                    break;
            }
            
        }break;
        case PetType_EDIT:{
            switch (indexPath.row) {
                case 0:
                {
                    cell.title.text=@"宠物昵称:";
                    cell.content.text=_pet.strName;
                }break;
                case 1:
                {
                    cell.title.text=@"宠物类型:";
                    cell.content.text=[NSString stringWithFormat:@"%i",_pet.nSortId];
                }break;
                case 2:
                {
                    cell.title.text=@"宠物年龄:";
                    cell.content.text=_pet.strBirthday;
                }break;
                case 3:
                {
                    cell.title.text=@"宠物性别:";
                    cell.content.text=[NSString stringWithFormat:@"%i",_pet.nSex];
                    ;
                }break;
                case 4:
                {
                    cell.title.text=@"宠物描述:";
                    cell.content.text=_pet.strDescription;
                }break;
                    
                default:
                    break;
            }
        
        }break;
        default:
            break;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    UIButton *addIcon=[[UIButton alloc]initWithFrame:CGRectMake((view.frame.size.width-80)*.5, (view.frame.size.height-80)*.5, 80, 80)];
    addIcon.backgroundColor=[UIColor redColor];
    [addIcon addTarget:self action:@selector(addIcon:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addIcon];
    view.backgroundColor=[UIColor yellowColor];
    return view;
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
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
    NSLog(@"image=%@",[info objectForKey:UIImagePickerControllerEditedImage]);
    [self upDateImage:[info objectForKey:UIImagePickerControllerEditedImage]];
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

-(void)upDateImage:(UIImage *)image{
    HttpUploadManager *upload=[[HttpUploadManager alloc]init];
    [upload uploadPetHead:image petId:@"-1"];
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
