//
//  MyPetsViewController.m
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyPetsViewController.h"
#import "LePetInfo.h"
#import "MapPetsViewController.h"
#import "MyPetService.h"
#import "PetDetailViewController.h"
#import "PetDetailViewController.h"
#import "MyPetTableViewCell.h"
#import "MyInfoService.h"

@interface MyPetsViewController ()<UITableViewDataSource,UITableViewDelegate,MyPetTableViewCellDelegate>{
    UITableView *_tableView;
}

@property (nonatomic,strong) NSMutableArray *pets;
@end

@implementation MyPetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initViews];
    
    MyInfoService *service=[[MyInfoService alloc]init];
    [service requestUserId:0];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self queryPets];
}

-(void)initParams{
    [self initData];
}

-(void)queryPets
{
    __block MyPetsViewController *weakSelf = self;
    MyPetService *service=[[MyPetService alloc]init];
    service.myPetsBlock=^(NSString *error,NSArray *pets)
    {
        weakSelf.pets=pets;
        [weakSelf->_tableView reloadData];

    };
    [service requestPetInfo:0];
}

-(void)initData
{
    self.pets=[NSMutableArray array];
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
}

-(void)initSelfView{
    self.title=@"我的宠物";
    [self setRightHidden:NO];
    [self setRightTitle:@"添加"];
    __weak MyPetsViewController *__self = self;
    [self addRightEvent:^(id sender)
     {
         PetDetailViewController *add=[[PetDetailViewController alloc]init];
         add.type=PetType_ADD;
         [__self.navigationController pushViewController:add animated:YES];
         
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, [self barSize].height, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    _tableView=tableView;
    [self.view addSubview:tableView];
    
    //1.设置tableview清除多余的分割线
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:line];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"MyPetSCELL";
    MyPetTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell=[[MyPetTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
       // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    LePetInfo *pet=[self.pets objectAtIndex:indexPath.row];
    [cell setValueWithPetInfo:pet];
    cell.delegate=self;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pets.count;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__FUNCTION__);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LePetInfo *pet=[self.pets objectAtIndex:indexPath.row];
    PetDetailViewController *edit=[[PetDetailViewController alloc]init];
    edit.nPetId=pet.nPetId;
    edit.type=PetType_EDIT;
    [self.navigationController pushViewController:edit animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


-(void)MyPetTableViewCell:(MyPetTableViewCell *)cell clickMap:(UIButton *)aBut{
    NSLog(@"%s",__FUNCTION__);
    MapPetsViewController *mapPets = [[MapPetsViewController alloc] init];
    [self presentViewController:mapPets animated:YES completion:nil];
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
