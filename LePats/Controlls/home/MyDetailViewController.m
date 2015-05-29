//
//  myDetailViewController.m
//  LePats
//
//  Created by admin on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MyDetailViewController.h"
#import "HomeItemModel.h"
#import "MyInfoService.h"
#import "MyDetailTableViewCell.h"

@interface MyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *itemList;
@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    // Do any additional setup after loading the view.
}

-(void)initParams{
    [self getUserInfo];

}

-(void)getUserInfo{
    MyInfoService *service=[[MyInfoService alloc]init];
    service.getMyInfoBlock=^(NSString *error){
        
    };
    [service requestUserId:0];
}

-(void)initData{


}

-(void)initViews{


}

-(void)initTableView{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMainScreenSize.width, KMainScreenSize.height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer=@"MyDetailCell";
    MyDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[MyDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else{
        return 40;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 5;
        }break;
        case 1:
        {
            return 3;
        }break;
        case 2:
        {
            return 2;
        }break;
        default:
            return 0;
            break;
    }
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
