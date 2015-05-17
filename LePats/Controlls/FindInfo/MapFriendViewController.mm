//
//  FriendViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapFriendViewController.h"

@interface MapFriendViewController()<BMKMapViewDelegate>

@end

@implementation MapFriendViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0, 64, kScreenSourchWidth, kScreenSourchHeight-64)];
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

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

-(void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    DLog(@"Map view Finish Loading");
}


@end
