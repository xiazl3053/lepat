//
//  FrindListViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FriendListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "BMKLocationService.h"
#import "UIView+Extension.h"
#import "FindService.h"
#import "FriendCell.h"
#import "Toast+UIView.h"
#import "NearInfo.h"

@interface FriendListViewController ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate>
{
    FindService *findSer;
    UILabel *lblLocation;
    CLLocationManager *locationManager;
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
}


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *aryNear;
@end

@implementation FriendListViewController

-(id)init
{
    self = [super init];
//    if([CLLocationManager locationServicesEnabled]) {
//        locationManager = [[CLLocationManager alloc] init];
//        locationManager.delegate = self;
//    }else {
//        //提示用户无法进行定位操作
//    }
//    // 开始定位
//    [locationManager startUpdatingLocation];
    return self;
}

-(void)startLocation
{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:100.0f];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

-(void)initHeadView
{
    self.title = @"附近鱼友列表";
    [self setRightHidden:NO];
    [self setRightRect:Rect(self.view.width-50,22, 36, 36)];
    [self setRightImg:@"position" high:nil select:nil];
    __weak FriendListViewController *__self = self;
    findSer = [[FindService alloc] init];
    _aryNear = [NSMutableArray array];
    [self addRightEvent:^(id sender)
    {
        [__self comeToMap];
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startLocation];
    [self initHeadView];
    [self initView];
//    [self findData];
}

-(void)comeToMap
{
    
}

-(void)findData
{
    __weak FriendListViewController *__self =self;
    findSer.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
        DLog(@"aryData_length:%lu",aryInfo.count);
        [__self.aryNear removeAllObjects];
        [__self.aryNear addObjectsFromArray:aryInfo];
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [__self.tableView reloadData];
        });
    };
    [findSer requestFindNear:fLat lng:fLong];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if([CLLocationManager locationServicesEnabled])
//    {
//        locationManager = [[CLLocationManager alloc] init];
//        locationManager.delegate = self;
//    }else
//    {
//        //提示用户无法进行定位操作
//        [self.view makeToast:@"请在通用中设置定位服务开启"];
//    }
//    // 开始定位
//    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    [locationManager startUpdatingLocation];
}


-(void)initView
{
   lblLocation = [[UILabel alloc] initWithFrame:Rect(0,[self barSize].height, self.view.width, 44)];
   [lblLocation setFont:XCFONT(20)];
   [self.view addSubview:lblLocation];
   
   [lblLocation setBackgroundColor:RGB(173, 173, 173)];
   [lblLocation setTextColor:RGB(255, 255, 255)];
    
   _tableView = [[UITableView alloc] initWithFrame:Rect(0, lblLocation.height+lblLocation.y, self.view.width,self.view.height-lblLocation.height-lblLocation.y-44)];
   [self.view addSubview:_tableView];
   _tableView.delegate = self;
   _tableView.dataSource = self;
   _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(!_aryNear)
   {
       return 0;
   }
   return [_aryNear count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *strFriendIdentifier = @"friendCellIdentifier";
   FriendCell *friend = [tableView dequeueReusableCellWithIdentifier:strFriendIdentifier];
   if (friend==nil)
   {
       friend = [[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strFriendIdentifier];
       NearInfo *near = [_aryNear objectAtIndex:indexPath.row];
       [friend setNearInfo:near];
   }
   return friend;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation
//{
//    
//    CLLocationCoordinate2D loc = [newLocation coordinate];
//    DLog(@"%f---%f",loc.latitude,loc.longitude);
//    //纬度
//    NSString *latitude = [NSString  stringWithFormat:@"%.4f", newLocation.coordinate.latitude];
//    
//    //经度
//    NSString *longitude = [NSString stringWithFormat:@"%.4f",                           newLocation.coordinate.longitude];
//}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    DLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    DLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    fLat = userLocation.location.coordinate.latitude;
    fLong = userLocation.location.coordinate.longitude;
    [self findData];
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
