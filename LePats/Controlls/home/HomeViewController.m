//
//  HomeViewController.m
//  LePats
//
//  Created by admin on 15/5/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeItemCollectionCell.h"
#import "UserInfo.h"
#import "HomeItemModel.h"
#import "HomeItemButton.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "MapFriendViewController.h"
#import "HomeHeadReusableView.h"


@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HomeItemCollectionCellDelegate>
@property (nonatomic,strong) NSMutableArray *itemList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    [self initViews];
    self.title=@"主页";
    // Do any additional setup after loading the view.
}


-(void)initViews{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,34,30)];
    [rightButton  setImage:[UIImage imageNamed:@"home_left"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showLeftView)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem= rightItem;
}

-(void)initParams{
    self.collectView.dataSource=self;
    self.collectView.delegate=self;
    [self.collectView registerClass:[HomeHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEAD_VIEW"];
    [self.collectView registerClass:[HomeItemCollectionCell class]
         forCellWithReuseIdentifier:@"MainHomeCell"];
    [self initTestData];
}

-(void)initTestData{
    
    NSMutableArray *section=[NSMutableArray array];
    NSMutableArray *section1=[NSMutableArray array];
    NSMutableArray *section2=[NSMutableArray array];
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"每日签到";
    model.tag=101;
    model.img=@"home_sign";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"我要寻宝";
    model1.tag=102;
    model1.img=@"home_find";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"我要砸蛋";
    model2.tag=103;
    model2.img=@"home_egg";
    
    [section addObject:model];
    [section addObject:model1];
    [section addObject:model2];
    
    HomeItemModel *model4 = [[HomeItemModel alloc] init];
    model4.title = @"大礼包";
    model4.tag = 105;
    model4.img = @"home_temp";
    
    HomeItemModel *model5 = [[HomeItemModel alloc] init];
    model5.title = @"大礼包";
    model5.tag = 105;
    model5.img = @"home_temp";
    
    HomeItemModel *model6 = [[HomeItemModel alloc] init];
    model6.title = @"大礼包";
    model6.tag = 105;
    model6.img = @"home_temp";
    
    HomeItemModel *model7 = [[HomeItemModel alloc] init];
    model7.title = @"大礼包";
    model7.tag = 105;
    model7.img = @"home_temp";
    
    HomeItemModel *model8 = [[HomeItemModel alloc] init];
    model8.title = @"大礼包";
    model8.tag = 105;
    model8.img = @"home_temp";
    
    [section1 addObject:model4];
    [section1 addObject:model5];
    [section1 addObject:model6];
    [section1 addObject:model7];
    [section1 addObject:model8];
    
    
    HomeItemModel *model9 = [[HomeItemModel alloc] init];
    model9.title = @"礼品兑换";
    model9.tag = 105;
    model9.img = @"home_convert";
    
    HomeItemModel *model10 = [[HomeItemModel alloc] init];
    model10.title = @"鱼你同行";
    model10.tag = 105;
    model10.img = @"home_withfish";
    
    HomeItemModel *model11 = [[HomeItemModel alloc] init];
    model11.title = @"寻找鱼友";
    model11.tag = 105;
    model11.img = @"home_findfish";
    
    HomeItemModel *model12 = [[HomeItemModel alloc] init];
    model12.title = @"邀请好友";
    model12.tag = 105;
    model12.img = @"home_ invite";
    
    [section2 addObject:model9];
    [section2 addObject:model10];
    [section2 addObject:model11];
    [section2 addObject:model12];
    
    self.itemList=[NSMutableArray array];
    [self.itemList addObject:section];
    [self.itemList addObject:section1];
    [self.itemList addObject:section2];
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusable=nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        

    }else{
        reusable=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEAD_VIEW" forIndexPath:indexPath];
    }
    return reusable;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(320, 200);
    }else{
        return CGSizeMake(0, 0);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *rows=[self.itemList objectAtIndex:section];
    return rows.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"MainHomeCell";
    
    //重用cell
    HomeItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate=self;
    NSArray *section=[self.itemList objectAtIndex:indexPath.section];
    HomeItemModel *model=[section objectAtIndex:indexPath.row];
    [cell setItemModel:model];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return CGSizeMake(self.view.frame.size.width/3.0, self.view.frame.size.width/3.0);
        }break;
        case 1:
        {
            return CGSizeMake(self.view.frame.size.width/5.0, self.view.frame.size.width/5.0);
        }break;
        case 2:
        {
            return CGSizeMake(self.view.frame.size.width/2.0, self.view.frame.size.width/2.0);
        }break;
            
        default:{
            return CGSizeMake(0, 0);
        }break;
    }
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
////每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void)homeItemCollectionCell:(HomeItemCollectionCell *)cell userClickHomeItemButton:(HomeItemButton *)btn{
    [self gotoViewControllerWithTag:btn.tag];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoViewControllerWithTag:(NSInteger)tag{
    switch (tag) {
        case 101:
        {
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            LoginViewController *info=[story instantiateViewControllerWithIdentifier:@"LoginViewController"];
//            info.view.backgroundColor=[UIColor yellowColor];
            if([UserInfo sharedUserInfo].strMobile ==nil)
            {
                LoginViewController *loginView = [[LoginViewController alloc] init];
                loginView.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:loginView animated:YES];
            }
        }break;
        case 102:
        {
            
        }break;
        case 105:
        {
            MapFriendViewController *mapFriend = [[MapFriendViewController alloc] init];
            [self.navigationController pushViewController:mapFriend animated:YES];
        }
        break;
        default:
            break;
    }
}

-(void)showLeftView{
    [[NSNotificationCenter defaultCenter]postNotificationName:KShowLeftViewController object:nil];

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
