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


@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HomeItemCollectionCellDelegate>
@property (nonatomic,strong) NSMutableArray *itemList;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParams];
    self.title=@"主页";
    // Do any additional setup after loading the view.
}

-(void)initParams{
    self.collectView.dataSource=self;
    self.collectView.delegate=self;
    [self.collectView registerClass:[HomeItemCollectionCell class]
         forCellWithReuseIdentifier:@"MainHomeCell"];
    [self initTestData];
}

-(void)initTestData{
    HomeItemModel *model=[[HomeItemModel alloc]init];
    model.title=@"水族";
    model.tag=101;
    model.img=@"my";
    
    HomeItemModel *model1=[[HomeItemModel alloc]init];
    model1.title=@"人族";
    model1.tag=102;
    model1.img=@"my";
    
    HomeItemModel *model2=[[HomeItemModel alloc]init];
    model2.title=@"兽族";
    model2.tag=103;
    model2.img=@"my";
    
    HomeItemModel *model5 = [[HomeItemModel alloc] init];
    model5.title = @"地图";
    model5.tag = 105;
    model5.img = @"my";
    
    self.itemList=[NSMutableArray array];
    [self.itemList addObject:model];
    [self.itemList addObject:model1];
    [self.itemList addObject:model2];
    [self.itemList addObject:model];
    [self.itemList addObject:model5];
    [self.itemList addObject:model2];
    [self.itemList addObject:model];
    [self.itemList addObject:model1];
    [self.itemList addObject:model2];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"MainHomeCell";
    
    //重用cell
    HomeItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.delegate=self;
    HomeItemModel *model=[self.itemList objectAtIndex:indexPath.row];
    
    [cell setItemModel:model];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/3.0, self.view.frame.size.width/3.0);
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
//            info.hidesBottomBarWhenPushed=YES;
            if([UserInfo sharedUserInfo].strMobile ==nil || [[UserInfo sharedUserInfo].strMobile isEqualToString:@""])
            {
                LoginViewController *loginView = [[LoginViewController alloc] init];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
