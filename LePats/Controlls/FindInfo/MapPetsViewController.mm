//
//  MapPetsViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapPetsViewController.h"
#import "BMKMapView.h"
#import "TheyMainViewController.h"
#import "BMKLocationComponent.h"
#import "UIView+Extension.h"
#import "BMKPointAnnotation.h"
#import "BMKPinAnnotationView.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "BDMarker.h"
#import "FindPetsService.h"

@interface MapPetsViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindPetsService *findSer;
    BMKPointAnnotation *bmk_my;
}
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) NSArray *aryPets;


@property (nonatomic,strong) NSMutableArray *aryAnnotation;
@property (nonatomic,strong) NSMutableArray *aryNear;

@end

@implementation MapPetsViewController

-(id)initWithItems:(NSArray*)array
{
    self = [super init];
    fLat = 0;
    fLong = 0;
    if (array.count>0)
    {
        _aryPets = array;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _aryNear = [NSMutableArray array];
    _aryAnnotation = [NSMutableArray array];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0, [self barSize].height, self.view.width,self.view.height-[self barSize].height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    findSer = [[FindPetsService alloc] init];
    [self startLocation];
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
    _mapView.delegate = self;
}

-(void)startLocation
{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:100.0f];
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    _locService.delegate = self;
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
    if(fLat == 0 || fLong == 0)
    {
        fLat = userLocation.location.coordinate.latitude;
        fLong = userLocation.location.coordinate.longitude;
        [self addMyLocation];
        [self findData];
    }
}

-(void)addMyLocation
{
    bmk_my = [[BMKPointAnnotation alloc] init];
    bmk_my.title = @"我";
    bmk_my.subtitle = @"我的位置";
    CLLocationCoordinate2D location2D;
    location2D.latitude = fLat;
    location2D.longitude = fLong;
    bmk_my.coordinate = location2D;
    [_mapView addAnnotation:bmk_my];
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
            UIView *view = [[UIView alloc] initWithFrame:Rect(0,0,30,30)];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.bounds];
            [imgView.layer setMasksToBounds:YES];
            [imgView.layer setCornerRadius:15.0f];
            [imgView sd_setImageWithURL:[NSURL URLWithString:[UserInfo sharedUserInfo].strUserIcon] placeholderImage:[UIImage imageNamed:@"left_icon_noraml"]];
            [view addSubview:imgView];
            imgView.frame = view.bounds;
            newAnnotationView.leftCalloutAccessoryView = view;
        }
        else
        {
            BDMarker *bMark = (BDMarker*)annotation;
            newAnnotationView.image = [UIImage imageNamed:@"marker_other"];
            UIView *view = [[UIView alloc] initWithFrame:Rect(0,0,30,30)];
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:view.bounds];
            [imgView.layer setMasksToBounds:YES];
            [imgView.layer setCornerRadius:15.0f];
            [imgView sd_setImageWithURL:[[NSURL alloc] initWithString:bMark.near.strFile] placeholderImage:[UIImage imageNamed:@""]];
            [view addSubview:imgView];
            imgView.frame = view.bounds;
            newAnnotationView.leftCalloutAccessoryView = view;
            
            [imgView setUserInteractionEnabled:YES];
            [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheyInfo:)]];
            
            DLog(@"bMark:%@",bMark.near);
        }
        return newAnnotationView;
    }
    return nil;
}

-(void)findData
{
    __weak MapPetsViewController *__self =self;
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
    [findSer requestPetLocation:fLat long:fLong];
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
        bmk.subtitle = [NSString stringWithFormat:@"距离您:%.01f m",near.fDistan];
        bmk.near = near;
        [_mapView addAnnotation:bmk];
    }
}

-(void)tagTheyInfo:(UITapGestureRecognizer *)sender
{
    UIImageView *imgView = (UIImageView *)sender.view;
    DLog(@"imgView:%d",(int)imgView.tag);
    NearInfo *near = [_aryNear objectAtIndex:imgView.tag];
    if (near)
    {
        TheyMainViewController *theyView = [[TheyMainViewController alloc] initWithNear:near];
        [self presentViewController:theyView animated:YES completion:nil];
    }
}


@end
