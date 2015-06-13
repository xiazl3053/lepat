//
//  GiftExchangeViewController.m
//  LePats
//
//  Created by admin on 15/6/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "GiftExchangeViewController.h"
#import "GIftExchangeModel.h"
#import "HomeItemModel.h"
#import "HomeHeadItemButton.h"
#import "GiftExchangeTableViewCell.h"

@interface GiftExchangeViewController ()<UITableViewDataSource,UITableViewDelegate>{
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation GiftExchangeViewController


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
    GIftExchangeModel *model=[[GIftExchangeModel alloc]init];
    model.title=@"每日签到送积分";
    model.like=13;
    model.number=100;
    
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
    model.title=@"虚拟商品";
    model.tag=101;
    model.img=@"my_gift_virtual";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"实物商品";
    model1.tag=102;
    model1.img=@"my_gift_kind1";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"实物商品";
    model2.tag=103;
    model2.img=@"my_gift_kind";
    
    HomeItemModel *model3=[[HomeItemModel alloc]init];
    model3.title=@"更多";
    model3.tag=103;
    model3.img=@"my_gift_more";
    
    NSMutableArray *section=[NSMutableArray array];
    [section addObject:model];
    [section addObject:model1];
    [section addObject:model2];
    [section addObject:model3];
    
    UIView *centerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    
    UIImageView  *top=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, centerView.width, 80)];
    top.image=[UIImage imageNamed:@"my_giftExchange_bg"];
    [centerView addSubview:top];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, centerView.bottom-.5, self.view.frame.size.width, 0.5)];
    line.backgroundColor=UIColorFromRGB(0xcbcccd);
    [centerView addSubview:line];
    
    
    for (int i=0; i<section.count; i++) {
        HomeItemModel *obj=[section objectAtIndex:i];
        HomeHeadItemButton *btn=[[HomeHeadItemButton alloc]initWithFrame:CGRectMake(i*KMainScreenSize.width/4.0, top.bottom, KMainScreenSize.width/4.0, 80)];
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
    GiftExchangeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[GiftExchangeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    GIftExchangeModel *model=[self.items objectAtIndex:indexPath.row];
    [cell setValueWithGiftExchangeModel:model];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
