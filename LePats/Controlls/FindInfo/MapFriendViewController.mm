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
#import "BMapKit.h"

@interface MapFriendViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindService *findSer;
    BMKPointAnnotation *bmk_my;
}
@property (nonatomic,strong) NSMutableArray *aryNear;
@end

@implementation MapFriendViewController

-(id)initWithLat:(CGFloat)fLatitude long:(CGFloat)fLongitude
{
    self = [super init];
    fLat = fLatitude;
    fLong = fLongitude;
    return self;
}

-(void)startLocation
{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:100.0f];
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _locService.delegate = self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _aryNear = [NSMutableArray array];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0,[self barSize].height, kScreenSourchWidth, kScreenSourchHeight-64)];
    self.title = @"地图";
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    if(fLat != 0 && fLong != 0)
    {
        BMKCoordinateRegion region;
        region.center.latitude  = fLat;
        region.center.longitude = fLong;
        region.span.latitudeDelta  = 0.2;
        region.span.longitudeDelta = 0.2;
        _mapView.region = region;
    }
    
    [self startLocation];
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
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        _mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        fLat = userLocation.location.coordinate.latitude;
        fLong = userLocation.location.coordinate.longitude;
    }
}

-(void)addFriend
{
    DLog(@"aryNear:%@",_aryNear);
}

-(void)dealloc
{
    [_locService stopUserLocationService];
    _locService = nil;
}


@end
