//
//  MyPetsViewController.m
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetDetailViewController.h"
#import "LePetInfo.h"
#import "AddPetService.h"
#import "HttpUploadManager.h"
#import "AddPetCellTableViewCell.h"
#import "PetInfoService.h"
#import "PetSortModel.h"
#import "PetSortService.h"
#import "DelPetService.h"
#import "PetInfoEditService.h"
#import "UserInfo.h"
#import "PetSort.h"
#import "ProgressHUD.h"
#import "Toast+UIView.h"
#import "AccessoryToolView.h"

@interface PetDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UITableView *_tableView;
    UIPickerView *_sortPickerView;
    UIPickerView *_sexPickerView;
    UIDatePicker *_datePickerView;
    AddPetCellTableViewCell *_sortCell;
    AddPetCellTableViewCell *_sexCell;
    AddPetCellTableViewCell *_dateCell;
    PetSortModel *_selectSortModel;
    NSInteger _photoId;
    UIImageView *_imgView;
    PetInfoService *petService;
    PetInfoEditService *editPetservice;
}

@property (nonatomic,strong) NSArray *sortList;
@property (nonatomic,strong) NSArray *sexList;
@property (nonatomic,strong) LePetInfo *pet;

@end

@implementation PetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self initParams];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    [self getPetSort];
    [self getPetInfo];
    [self initData];
}

-(void)getPetInfo{
    if (self.type==PetType_EDIT||self.type==PetType_TA) {
        [self queryPetInfo];
    }else{
        self.pet=[[LePetInfo alloc]init];
    }
}

-(void)getPetSort{
    
    self.sortList=[PetSort sharedPetSort].petListArr;
    
    //    PetSortService *service=[[PetSortService alloc]init];
    //    __weak PetDetailViewController *__self=self;
    //    service.getPetSortBlock=^(NSString *error,NSArray *data){
    //        __self.sortList=data;
    //    };
    //    [service requestPetSort];
}

-(void)initData{
    self.sexList=[NSArray arrayWithObjects:@"男",@"女",nil];
}

-(void)queryPetInfo{
    petService=[[PetInfoService alloc]init];
    __weak PetDetailViewController *__self=self;
    petService.getPetInfoBlock=^(NSString *error,LePetInfo *pet){
        if (error) {
             [__self.view makeToast:error];
        }else{
            __self.pet=pet;
            if (self.type==PetType_ADD) {
                [_imgView sd_setImageWithURL:[NSURL URLWithString:pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"pet_add"]];
            }else{
                [_imgView sd_setImageWithURL:[NSURL URLWithString:pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
            }
            __self.title=_pet.strName;
            [_tableView reloadData];
        }
    };
    switch (self.type) {
        case PetType_ADD:
        {
            [petService requestPetInfo:_pet.nPetId];
        }break;
        case PetType_EDIT:{
            [petService requestPetInfo:self.nPetId];
        }break;
        case PetType_TA:{
            _tableView.userInteractionEnabled=NO;
            [petService requestPetInfo:self.nPetId];
        }break;
            
        default:
            break;
    }
//    if (self.type==PetType_ADD) {
//        
//    }else{
//        [pet requestPetInfo:self.nPetId];
//    }
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
    [picker addTarget:self action:@selector(dataPickerValueChange:) forControlEvents:UIControlEventValueChanged];
    _datePickerView=picker;
}

-(void)initSelfView{
    
    if (self.type==PetType_EDIT) {
        [self setRightHidden:NO];
        [self setRightTitle:@"保存"];
        __weak PetDetailViewController *__self = self;
        [self addRightEvent:^(id sender){
            if ([__self completa]) {
                editPetservice=[[PetInfoEditService alloc]init];
                editPetservice.editPetBlock=^(NSString *error){
                    if (error) {
                        [__self.view makeToast:error];
                    }else{
                        [__self.navigationController popViewControllerAnimated:YES];
                    }
                };
                [editPetservice requestEditPet:__self.pet];
            }else{
                [__self.view makeToast:@"请输入完整的宠物信息"];
                NSLog(@"信息错误");
            }
        }];
    }else{
        self.title=@"添加宠物";
    }
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

-(void)submitPetInfoView{
    
    
    
    UIButton *submit=[[UIButton alloc]initWithFrame:CGRectMake(10, _tableView.bottom+40, KMainScreenSize.width-20, 40)];
    [self.view addSubview:submit];
    [submit setBackgroundColor:RGB(0, 146, 255)];
    [submit.layer setMasksToBounds:YES];
    submit.layer.cornerRadius = 3.0f;
    
    if (self.type==PetType_TA) {
        submit.hidden=YES;
    }
    
    if (self.type==PetType_EDIT) {
        [submit setTitle:@"删除" forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(del) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [submit setTitle:@"确定" forState:UIControlStateNormal];
        [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
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
    
    
    __weak typeof(self) weakSelf=self;
    if ([self completa]) {
        AddPetService *service=[[AddPetService alloc]init];
        service.addPetBlock=^(NSString *error){
            if (error) {
                [weakSelf.view makeToast:error];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };
        [service requestAddPet:_pet];
    }else{
        [self.view makeToast:@"输入信息不完整"];
        NSLog(@"信息错误");
    }
}

-(void)del{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"确定删除宠物!"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag=100;
    [actionSheet showInView:self.view];
}

-(BOOL)completa{
    for (AddPetCellTableViewCell *cell in [_tableView visibleCells]) {
        if ([cell.content.text isEqualToString:@""]) {
            NSLog(@"cell.content.text=%@",cell.content.text);
            return NO;
        }else{
            switch (cell.tag) {
                case 0:
                {
                    _pet.strName=cell.content.text;
                }break;
                case 1:
                {
                    _pet.nSortId=_pet.nSortId;
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
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, [self barSize].height, self.view.frame.size.width, 5*44+100) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    _tableView=tableView;
    [self.view addSubview:tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"ADDPETCELL";
    AddPetCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[AddPetCellTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    switch (self.type) {
        case PetType_TA:{}
        case PetType_EDIT:PetType_TA:{
            switch (indexPath.row) {
                case 0:
                {
                    cell.title.text=@"宠物昵称:";
                    cell.content.text=_pet.strName;
                }break;
                case 1:
                {
                    cell.title.text=@"宠物类型:";
                    cell.content.inputView=_sortPickerView;
                    _sortCell=cell;
                    for (PetSortModel *model in _sortList) {
                        if ([model.iD intValue]==_pet.nSortId) {
                            cell.content.text=[NSString stringWithFormat:@"%@",model.name];
                        }
                    }
                    AccessoryToolView *accessory=[[AccessoryToolView alloc]init];
                    accessory.accessoryToolViewClickBlock=^(NSInteger index){
                        [_tableView endEditing:YES];
                        if (index==1) {
                            NSLog(@"取消");
                        }else{
                            NSInteger row=[_sortPickerView selectedRowInComponent:0];
                            PetSortModel *model=[self.sortList objectAtIndex:row];
                            _sortCell.content.text=model.name;
                            self.pet.nSortId=[model.iD intValue];
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                }break;
                case 2:
                {
                    cell.title.text=@"宠物年龄:";
                    cell.content.text=_pet.strBirthday;
                    cell.content.inputView=_datePickerView;
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
                            _dateCell.content.text=dateString;
                            _pet.strBirthday=dateString;
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                    _dateCell=cell;
                }break;
                case 3:
                {
                    cell.title.text=@"宠物性别:";
                    cell.content.inputView=_sexPickerView;
                    cell.content.text=[NSString stringWithFormat:@"%@",_pet.nSex==PET_SEX_MALE?@"男":@"女"];
                    AccessoryToolView *accessory=[[AccessoryToolView alloc]init];
                    accessory.accessoryToolViewClickBlock=^(NSInteger index){
                        [_tableView endEditing:YES];
                        if (index==1) {
                            NSLog(@"取消");
                        }else{
                            NSInteger row=[_sexPickerView selectedRowInComponent:0];
                            _sexCell.content.text=[_sexList objectAtIndex:row];
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                    _sexCell=cell;
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
                    AccessoryToolView *accessory=[[AccessoryToolView alloc]init];
                    accessory.accessoryToolViewClickBlock=^(NSInteger index){
                        [_tableView endEditing:YES];
                        if (index==1) {
                            NSLog(@"取消");
                        }else{
                            NSInteger row=[_sortPickerView selectedRowInComponent:0];
                            PetSortModel *model=[self.sortList objectAtIndex:row];
                            _sortCell.content.text=model.name;
                            _pet.nSortId=[model.iD intValue];
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                    _sortCell=cell;
                    //cell.detailTextLabel.text=[NSString stringWithFormat:@"%i",_pet.nSortId];
                }break;
                case 2:
                {
                    cell.title.text=@"宠物年龄:";
                    cell.content.inputView=_datePickerView;
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
                            _dateCell.content.text=dateString;
                            _pet.strBirthday=dateString;
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                    _dateCell=cell;
                    //cell.detailTextLabel.text=_pet.strBirthday;
                }break;
                case 3:
                {
                    cell.title.text=@"宠物性别:";
                    cell.content.inputView=_sexPickerView;
                    AccessoryToolView *accessory=[[AccessoryToolView alloc]init];
                    accessory.accessoryToolViewClickBlock=^(NSInteger index){
                        [_tableView endEditing:YES];
                        if (index==1) {
                            NSLog(@"取消");
                        }else{
                            NSInteger row=[_sexPickerView selectedRowInComponent:0];
                            _sexCell.content.text=[_sexList objectAtIndex:row];
                            NSLog(@"完成");
                        }
                    };
                    cell.content.inputAccessoryView=accessory;
                    
                    _sexCell=cell;
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
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:headView.bounds];
    bgView.image=[UIImage imageNamed:@"headView_bg"];
    [headView addSubview:bgView];
    
    UIImageView *add=[[UIImageView alloc]initWithFrame:CGRectMake((headView.frame.size.width-80)*.5, (headView.frame.size.height-80)*.5, 80, 80)];
    
    add.layer.cornerRadius=add.width*.5;
    add.layer.masksToBounds=YES;
    add.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addIcon:)];
    //[add addTarget:self action:@selector(addIcon:) forControlEvents:UIControlEventTouchUpInside];
    [add addGestureRecognizer:tap];
    add.userInteractionEnabled=YES;
    _imgView=add;
    
    if (self.type==PetType_ADD) {
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"pet_add"]];
    }else{
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
    }
    
    [headView addSubview:add];
    
    return headView;
}



-(void)addIcon:(UIButton *)aBtn{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"本地相册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag=200;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex=%li",buttonIndex);
    switch (actionSheet.tag) {
        case 100:{
            switch (buttonIndex) {
                case 0:
                {
                        DelPetService *service=[[DelPetService alloc]init];
                        __block PetDetailViewController *__self=self;
                        service.delPetBlock=^(NSString *error){
                            if (error) {
                    
                            }else{
                                [__self.navigationController popViewControllerAnimated:YES];
                            }
                        };
                        [service requestDelPetInfo:self.nPetId];
                
                }break;
                case 1:{
                
                }break;
                default:
                    break;
            }
            
        }break;
        case 200:{
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
        }break;
            
        default:
            break;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [scrollView endEditing:YES];
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
//            PetSortModel *model=[self.sortList objectAtIndex:row];
//            _sortCell.content.text=model.name;
//            _selectSortModel=model;
        }break;
        case 200:{
            //NSString *sex=[self.sexList objectAtIndex:row];
            //_sexCell.content.text=sex;
        }break;
        default:
            break;
    }
}

-(void)upDateImage:(UIImage *)image{
    [ProgressHUD show:@"上传头像..."];
    __weak PetDetailViewController *__self=self;
    HttpUploadManager *upload=[[HttpUploadManager alloc]init];
    upload.uploadImgBlock=^(NSString *error,NSDictionary *dic){
        [ProgressHUD dismiss];
        if (error) {
            [__self.view makeToast:error];
        }else{
            NSDictionary *data=[dic objectForKey:@"photobj"];
            _photoId=[[data objectForKey:@"id"]intValue];
            _pet.nPhotoId=[[data objectForKey:@"id"]intValue];
            _pet.strIconUrl=[NSString stringWithFormat:@"%@%@",[data objectForKey:@"host"],[data objectForKey:@"photouri"]];
            if (self.type==PetType_ADD) {
                [_imgView sd_setImageWithURL:[NSURL URLWithString:_pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"pet_add"]];
            }else{
                [_imgView sd_setImageWithURL:[NSURL URLWithString:_pet.strIconUrl] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
            }
        }
    };
    [upload uploadPetHead:image petId:[NSString stringWithFormat:@"%d",_pet.nPetId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"%s",__FUNCTION__);
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
