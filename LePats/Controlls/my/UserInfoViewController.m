//
//  UserInfoViewController.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserDetailViewController.h"
#import "HomeItemModel.h"
@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *itemList;

@end

@implementation UserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self initParams];
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    self.itemList=[NSMutableArray array];
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"我的QQ会员";
    model.img=@"my";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"QQ钱包";
    model1.img=@"my";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"网上营业厅";
    model2.img=@"my";
    
    [self.itemList addObject:model];
    [self.itemList addObject:model1];
    [self.itemList addObject:model2];
    
}

-(void)initViews{
    [self initTableView];
}

-(void)initTableView{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 80, 260, self.view.frame.size.height-80) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"CELL";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HomeItemModel *model=[self.itemList objectAtIndex:indexPath.row];
    cell.textLabel.text=model.title;
    return cell;
}
- (IBAction)back:(id)sender {
    NSLog(@"self.navigationController=%@",self.navigationController);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click:(id)sender {
    UserDetailViewController *detail=[[UserDetailViewController alloc]init];
    detail.view.backgroundColor=[UIColor blueColor];
    detail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detail animated:YES];
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
