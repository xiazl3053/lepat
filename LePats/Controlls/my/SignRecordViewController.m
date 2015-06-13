//
//  SignRecordViewController.m
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "SignRecordViewController.h"
#import "HomeItemModel.h"
#import "HomeHeadItemButton.h"
#import "RecordModel.h"
#import "RecordTableViewCell.h"

@interface SignRecordViewController ()<UITableViewDataSource,UITableViewDelegate>{

}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *items;
@end

@implementation SignRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initViews];
    [self initParams];
}

-(void)initViews{
    [self initSelfView];
    [self initTableView];
}

-(void)initSelfView{
    self.title=@"记录数";
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)initParams{
    [self initTestData];
}

-(void)initTestData{
    RecordModel *model=[[RecordModel alloc]init];
    model.title=@"每日签到送积分";
    model.time=[[NSDate date]timeIntervalSince1970];
    model.score=10;
    
    self.items=[NSMutableArray arrayWithObjects:model,model,model,model,model,model,model,model,model, nil];
}

-(void)initTableView{
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, [self barSize].height,KMainScreenSize.width,KMainScreenSize.height-[self barSize].height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    [self initTableHeaderView];
}

-(void)initTableHeaderView{
    
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"签到记录";
    model.tag=101;
    model.img=@"my_gift_1";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"寻宝记录";
    model1.tag=102;
    model1.img=@"my_gift_2";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"砸蛋记录";
    model2.tag=103;
    model2.img=@"my_gift_3";
    
    HomeItemModel *model3=[[HomeItemModel alloc]init];
    model3.title=@"全部记录";
    model3.tag=103;
    model3.img=@"my_gift_1";
    
    NSMutableArray *section=[NSMutableArray array];
    [section addObject:model];
    [section addObject:model1];
    [section addObject:model2];
    [section addObject:model3];
    
    UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, centerView.bottom-.5, self.view.frame.size.width, 0.5)];
    line.backgroundColor=UIColorFromRGB(0xcbcccd);
    [centerView addSubview:line];
    
    
    for (int i=0; i<section.count; i++) {
        HomeItemModel *obj=[section objectAtIndex:i];
        HomeHeadItemButton *btn=[[HomeHeadItemButton alloc]initWithFrame:CGRectMake(i*KMainScreenSize.width/4.0, 5, KMainScreenSize.width/4.0, centerView.height)];
        [btn setImage:[UIImage imageNamed:obj.img] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [btn setTitle:obj.title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [centerView addSubview:btn];
    }
    self.tableView.tableHeaderView=centerView;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifer=@"RecordTableViewCell";
    RecordTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[RecordTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    RecordModel *model=[self.items objectAtIndex:indexPath.row];
    [cell setValueWithRecordModel:model];
    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(void)changeView:(UIButton *)aBtn{

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
