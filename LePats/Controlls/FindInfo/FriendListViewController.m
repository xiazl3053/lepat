//
//  FrindListViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/5/28.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "FriendListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "FocusService.h"
#import "BMKGeoCodeSearch.h"
#import "MapFriendViewController.h"
#import "BMKLocationService.h"
#import "UIView+Extension.h"
#import "FindService.h"
#import "FriendCell.h"
#import "Toast+UIView.h"
#import "NearInfo.h"
#import "ProgressHUD.h"

@interface FriendListViewController ()<UITableViewDataSource,FriendViewDelegate,UITableViewDelegate,CLLocationManagerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    FindService *findSer;
    UILabel *lblLocation;
    CLLocationManager *locationManager;
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    BMKGeoCodeSearch *search;
    BOOL bTrue;
    FocusService *focus;
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
    [_locService startUserLocationService];
    _locService.delegate = self;
    bTrue = YES;
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
    search = [[BMKGeoCodeSearch alloc] init];
    search.delegate = self;
    focus = [[FocusService alloc] init];
    [ProgressHUD show:@"正在定位..."];
}

-(void)focusUserInfo:(NSString *)strUserId
{
    focus.httpFocus = ^(int nStauts,NSString *strMsg)
    {
        if (nStauts == 200) {
            
        }
        else
        {
            
        }
    };
    [focus requestFocus:strUserId];
}

-(void)comeToMap
{
    [_locService stopUserLocationService];
    MapFriendViewController *map =[[MapFriendViewController alloc] initWithLat:fLat long:fLong];
    [self presentViewController:map animated:YES completion:nil];
}

-(void)findData
{
    __weak FriendListViewController *__self =self;
    findSer.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
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
}


-(void)initView
{
   lblLocation = [[UILabel alloc] initWithFrame:Rect(0,[self barSize].height, self.view.width, 44)];
   [lblLocation setFont:XCFONT(15)];
   [self.view addSubview:lblLocation];
   
   [lblLocation setBackgroundColor:RGB(173, 173, 173)];
   [lblLocation setTextColor:RGB(255, 255, 255)];
   [lblLocation setText:@"        正在解析您的位置..."];
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
       friend.delegate = self;
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

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    DLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    DLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if(fLat != userLocation.location.coordinate.latitude ||
       fLong != userLocation.location.coordinate.longitude)
    {
        fLat = userLocation.location.coordinate.latitude;
        fLong = userLocation.location.coordinate.longitude;
        [self findData];
        //BMKReverseGeoCodeOption
        BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
        //需要逆地理编码的坐标位置
        reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
        [search reverseGeoCode:reverseGeoCodeOption];
        lblLocation.text = [NSString stringWithFormat:@"     正在解析您的位置..."];
        [ProgressHUD dismiss];
    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    DLog(@"result:%@",result.address);
    dispatch_async(dispatch_get_main_queue(),
    ^{
        lblLocation.text = [NSString stringWithFormat:@"     您当前的位置:%@",result.address];
        
    });
}

-(void)friendView:(FriendCell *)friend focus:(NSString *)strUserId
{
    if(focus==nil)
    {
        focus = [[FocusService alloc] init];
    }
    __weak FriendListViewController *__self = self;
    __weak FriendCell *__friend = friend;
    focus.httpFocus = ^(int nStatus,NSString *strMsg)
    {
        if (nStatus == 1)
        {
            dispatch_async(dispatch_get_main_queue(),
            ^{
                [__friend setAttenBtnSwtich];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(),
            ^{
                [__self.view makeToast:strMsg duration:1.5 position:@"center"];
            });
        }
    };
    [focus requestFocus:strUserId];
}

@end
