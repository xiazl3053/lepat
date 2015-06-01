//
//  FriendViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapFriendViewController.h"
#import "BMKLocationComponent.h"
#import "FindService.h"


@interface MapFriendViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindService *findSer;
}
@property (nonatomic,strong) NSMutableArray *aryNear;
@end

@implementation MapFriendViewController

-(void)startLocation
{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:100.0f];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _aryNear = [NSMutableArray array];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0,[self barSize].height, kScreenSourchWidth, kScreenSourchHeight-64)];
    self.title = @"地图";
    
    [self.view addSubview:_mapView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"map view: double click");
}

-(void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    DLog(@"Map view Finish Loading");
}

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
    CLLocationCoordinate2D location;
    location.latitude = fLat;
    location.longitude = fLong;
    [_mapView setCenterCoordinate:location animated:YES];
    [self findData];
}


-(void)findData
{
    __weak MapFriendViewController *__self =self;
    findSer.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
        DLog(@"aryData_length:%lu",aryInfo.count);
        [__self.aryNear removeAllObjects];
        [__self.aryNear addObjectsFromArray:aryInfo];
      
    };
    [findSer requestFindNear:fLat lng:fLong];
}

-(void)addFriend
{
    DLog(@"aryNear:%@",_aryNear);
}

@end
