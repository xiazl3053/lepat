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
#import "PetSortModel.h"
#import "PetSortService.h"

@interface AddPetViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    LePetInfo *_pet;
    UITableView *_tableView;
    UIPickerView *_sortPickerView;
    UIPickerView *_sexPickerView;
    UIDatePicker *_datePickerView;
    AddPetCellTableViewCell *_sortCell;
    AddPetCellTableViewCell *_sexCell;
    PetSortModel *_selectSortModel;
}

@property (nonatomic,strong) NSArray *sortList;
@property (nonatomic,strong) NSArray *sexList;

@end

@implementation AddPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    //[self initData];
    
    self.sexList=[NSArray arrayWithObjects:@"男",@"女",nil];
    
    if (self.type==PetType_EDIT) {
        [self getPetInfo];
    }else{
        _pet=[[LePetInfo alloc]init];
    }
    
    [self getPetSort];
}

-(void)getPetSort{
    PetSortService *service=[[PetSortService alloc]init];
    service.getPetSortBlock=^(NSString *error,NSArray *data){
        _sortList=data;
    };
    [service requestPetSort];
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

-(void)getPetInfo{
    PetInfoService *pet=[[PetInfoService alloc]init];
    pet.petInfoBlock=^(NSString *error,NSDictionary *dic){
        if (error) {
            
        }else{
            _pet=[[LePetInfo alloc]initWithNSDictionary:[dic objectForKey:@"pet"]];
            self.title=_pet.strName;
            [_tableView reloadData];
        }
    };
    [pet requestPetInfo:self.nPetId];
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
    [self submitPetInfoView];
    [self initPickerView];
}

-(void)initPickerView{
    [self initSortPickerView];
    [self initSexPickerView];
    [self initDatePickerView];
}

-(void)initSexPickerView{
    UIPickerView *picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    picker.delegate=self;
    picker.tag=100;
    _sortPickerView=picker;
}

-(void)initSortPickerView{
    UIPickerView *picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    picker.delegate=self;
    picker.tag=200;
    _sexPickerView=picker;
}

-(void)initDatePickerView{
    UIDatePicker *picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100)];
    [picker setDate:[NSDate date] animated:YES];
    [picker setDatePickerMode:UIDatePickerModeDate];
    [picker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventTouchUpInside];
    _datePickerView=picker;

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

-(void)dataPickerValueChange:(UIDatePicker *)picker{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString* dateString = [fmt stringFromDate:picker.date];
    _pet.strBirthday=dateString;
    NSLog(@"%@",dateString);
}

-(void)submit
{
//    LePetInfo *pet=[[LePetInfo alloc]init];
//    NSString *strName = @"猫-2";
//    NSString *strDescription = @"描述-1";
////  stringByAddingPercentEscapesUsingEncoding
//    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    pet.strName=[strName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    pet.strBirthday=@"2015-05-27";
//    pet.nSex=0;
//    pet.strDescription=[strDescription stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    pet.nSortId=3;
    
    if ([self completa]) {
        NSLog(@"信息错误");
    }else{
        AddPetService *service=[[AddPetService alloc]init];
        [service requestAddPet:_pet];
    }
}

-(BOOL)completa{
    for (AddPetCellTableViewCell *cell in [_tableView visibleCells]) {
        if ([cell.content.text isEqualToString:@""]) {
            return NO;
        }else{
            switch (cell.tag) {
                case 0:
                {
                    _pet.strName=cell.content.text;
                }break;
                case 1:
                {
                    _pet.nSortId=[_selectSortModel.iD intValue];
                }break;
                case 2:{
                    
                }break;
                case 3:{
                    _pet.nSex=[cell.content.text isEqualToString:@"男"]?PET_SEX_MALE:PET_SEX_FEMALE;
                }break;
                case 4:{
                    _pet.strDescription=cell.content.text;
                }break;
                default:
                    break;
            }
        }
        
    }
    return YES;
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
                    cell.content.inputView=_sortPickerView;
                    //cell.detailTextLabel.text=[NSString stringWithFormat:@"%i",_pet.nSortId];
                }break;
                case 2:
                {
                    cell.title.text=@"宠物年龄:";
                    cell.content.inputView=_datePickerView;
                    //cell.detailTextLabel.text=_pet.strBirthday;
                }break;
                case 3:
                {
                    cell.title.text=@"宠物性别:";
                    cell.content.inputView=_sexPickerView;
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
    cell.tag=indexPath.row;
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

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 100:
        {
            return self.sortList.count;
        }break;
        case 200:{
            return self.sexList.count;
        }
        default:{
            return 0;
        }break;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 100:
        {
            PetSortModel *model=[self.sortList objectAtIndex:row];
            return model.name;
        }break;
        case 200:{
            NSString *sex=[self.sexList objectAtIndex:row];
            return sex;
        }break;
        default:
            return @"";
            break;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 100:
        {
            PetSortModel *model=[self.sortList objectAtIndex:row];
            _sortCell.content.text=model.name;
            _selectSortModel=model;
        }break;
        case 200:{
            NSString *sex=[self.sortList objectAtIndex:row];
            _sexCell.content.text=sex;
        }break;
        default:
            break;
    }
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
