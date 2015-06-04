//
//  FriendViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapFriendViewController.h"
#import "BMKLocationComponent.h"
#import "NearInfo.h"
#import "UIImageView+WebCache.h"
#import "FindService.h"
#import "BDMarker.h"
#import "BMapKit.h"

@interface MapFriendViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindService *findSer;
    BMKPointAnnotation *bmk_my;
    BDMarker *bdMarker;
}
@property (nonatomic,strong) NSMutableArray *aryAnnotation;
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
    _aryAnnotation = [NSMutableArray array];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0,[self barSize].height, kScreenSourchWidth, kScreenSourchHeight-64)];
    self.title = @"地图";
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    findSer = [[FindService alloc] init];
    if(fLat != 0 && fLong != 0)
    {
        BMKCoordinateRegion region;
        region.center.latitude  = fLat;
        region.center.longitude = fLong;
        region.span.latitudeDelta  = 0.2;
        region.span.longitudeDelta = 0.2;
        _mapView.region = region;
        bmk_my = [[BMKPointAnnotation alloc] init];
        bmk_my.title = @"我";
        bmk_my.subtitle = @"我的位置";
        CLLocationCoordinate2D location2D;
        location2D.latitude = fLat;
        location2D.longitude = fLong;
        bmk_my.coordinate = location2D;
        [_mapView addAnnotation:bmk_my];
        [self findData];
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
#pragma mark 地图实现
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

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
 
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        newAnnotationView.annotation=annotation;
        if ([[annotation title] isEqualToString:@"我"])
        {
            newAnnotationView.image = [UIImage imageNamed:@"marker_my"];
            UIView *view = [[UIView alloc] initWithFrame:Rect(0,0,44,44)];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my"]];
            [view addSubview:imgView];
            imgView.frame = view.bounds;
            newAnnotationView.leftCalloutAccessoryView = view;
        }
        else
        {
            BDMarker *bMark = (BDMarker*)annotation;
            newAnnotationView.image = [UIImage imageNamed:@"marker_other"];
            UIView *view = [[UIView alloc] initWithFrame:Rect(0,0,44,44)];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.bounds];
            [imgView sd_setImageWithURL:[[NSURL alloc] initWithString:bMark.near.strFile] placeholderImage:[UIImage imageNamed:@""]];
            [view addSubview:imgView];
            imgView.frame = view.bounds;
            newAnnotationView.leftCalloutAccessoryView = view;
            DLog(@"bMark:%@",bMark.near);
        }
        return newAnnotationView;
    }
    return nil;
    
}

-(void)loadImageView:(UIImage *)image
{
    
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
}


-(void)findData
{
    __weak MapFriendViewController *__self =self;
    findSer.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
        DLog(@"aryData_length:%lu",aryInfo.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [__self removeAnnotation];
        });
        [__self.aryNear removeAllObjects];
        [__self.aryNear addObjectsFromArray:aryInfo];
        dispatch_async(dispatch_get_main_queue(),
        ^{
            [__self addAnnotation];
        });
    };
    [findSer requestFindNear:fLat lng:fLong];
}

-(void)removeAnnotation
{
    [_mapView removeAnnotations:_aryAnnotation];
    [_aryAnnotation removeAllObjects];
}

-(void)addAnnotation
{
    for (NearInfo *near in _aryNear)
    {
        BDMarker *bmk = [[BDMarker alloc] init];
        CLLocationCoordinate2D location;
        location.latitude = near.fLat;
        location.longitude = near.fLong;
        bmk.coordinate = location;
        bmk.title = near.strName;
        bmk.near = near;
        [_mapView addAnnotation:bmk];
//        [_aryAnnotation addObject:bmk];
    }
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
    }
    if(fLat != 0 || fLong != 0)
    {
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
