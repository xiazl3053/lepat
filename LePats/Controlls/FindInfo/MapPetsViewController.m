//
//  MapPetsViewController.m
//  LePats
//
//  Created by 夏钟林 on 15/6/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapPetsViewController.h"
#import "BMKMapView.h"
#import "BMKLocationComponent.h"
#import "UIView+Extension.h"
@interface MapPetsViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *_locService;
}
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) NSArray *aryPets;
@end

@implementation MapPetsViewController

-(id)initWithItems:(NSArray*)array
{
    self = [super init];
    if (array.count>0)
    {
        _aryPets = array;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0, [self barSize].height, self.view.width,self.view.height-[self barSize].height)];
    _mapView.delegate = self;
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
    _mapView.delegate = self;
}

//
//-(void)startLocation
//{
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
//    [BMKLocationService setLocationDistanceFilter:100.0f];
//    _locService = [[BMKLocationService alloc]init];
//    [_locService startUserLocationService];
//    _locService.delegate = self;
//}
//


@end
