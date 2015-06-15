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
#import "Toast+UIView.h"
#import "UIView+Extension.h"
#import "BMKPointAnnotation.h"
#import "BMKPinAnnotationView.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "BDMarker.h"
#import "PetSort.h"
#import "PetSortModel.h"
#import "FindPetsService.h"
#import "PetsButton.h"

@interface MapPetsViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindPetsService *findPets;
    BMKPointAnnotation *bmk_my;
    UIScrollView *scrolView;
    UIView *topView;
    NSArray *filterData;
    UISearchDisplayController *searchDisplayController;
}
@property (nonatomic,strong) UITableView *tableView;
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

-(void)mapZoomIn
{
    if (_mapView) {
        [_mapView zoomIn];
    }
}

-(void)mapZoomOut
{
    if (_mapView)
    {
        [_mapView zoomOut];
    }
}

-(void)initTableView
{
    UIButton *btnIn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnIn setImage:[UIImage imageNamed:@"map_zoomIn"] forState:UIControlStateNormal];
    [self.view addSubview:btnIn];
    [btnIn addTarget:self action:@selector(mapZoomIn) forControlEvents:UIControlEventTouchUpInside];
    btnIn.frame = Rect(self.view.width - 50,self.view.height-160,40,40);
    
    UIButton *btnOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOut setImage:[UIImage imageNamed:@"map_ZoomOut"] forState:UIControlStateNormal];
    [self.view addSubview:btnOut];
    [btnOut addTarget:self action:@selector(mapZoomOut) forControlEvents:UIControlEventTouchUpInside];
    btnOut.frame = Rect(self.view.width-50,self.view.height-116,40,40);
 
    topView = [[UIView alloc] initWithFrame:Rect(0,0,self.view.width,self.view.height)];
    [self.view addSubview:topView];
    
    UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClick setBackgroundColor:[UIColor clearColor]];
    [topView addSubview:btnClick];
    btnClick.frame = topView.bounds;
    [btnClick addTarget:self action:@selector(TopViewChange) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView =[[UITableView alloc] initWithFrame:Rect(0,(self.view.height-300)/2,self.view.width,300) style:UITableViewStyleGrouped];
    [topView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, _tableView.y-44, self.view.frame.size.width, 44)];
    searchBar.placeholder = @"搜索";
    
    [topView addSubview:searchBar];
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    topView.hidden = YES;
}

-(void)TopViewChange
{
    topView.hidden = !topView.hidden;
}

-(void)initWithScrol
{
    scrolView = [[UIScrollView alloc] initWithFrame:Rect(0,self.view.height-75,self.view.width,75)];
    [scrolView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:scrolView];
    PetsButton *btnAll = [[PetsButton alloc] initWithTitle:@"全部" nor:@"yulei_all" high:@"yulei_all" frame:Rect(15,6,44,60)];
    [scrolView addSubview:btnAll];
    btnAll.tag = 10000;
    [btnAll addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnLong = [[PetsButton alloc] initWithTitle:@"龙鱼" nor:@"longyu" high:@"longyu" frame:Rect(btnAll.width+btnAll.x+15,6,44,60)];
    [scrolView addSubview:btnLong];
    btnLong.tag = 10015;
    [btnLong addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnKing = [[PetsButton alloc] initWithTitle:@"金鱼" nor:@"jinyu" high:@"jinyu" frame:Rect(btnLong.width+btnLong.x+18,6,44,60)];
    [scrolView addSubview:btnKing];
    btnKing.tag = 10012;
    [btnKing addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnXiao = [[PetsButton alloc] initWithTitle:@"小丑鱼" nor:@"xiaochou" high:@"xiaochou" frame:Rect(btnKing.width+btnKing.x+18,6,44,60)];
    [scrolView addSubview:btnXiao];
    btnXiao.tag = 10040;
    [btnXiao addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnJin = [[PetsButton alloc] initWithTitle:@"锦鲤" nor:@"jinli" high:@"jinli" frame:Rect(btnXiao.width+btnXiao.x+18,6,44,60)];
    [scrolView addSubview:btnJin];
    btnJin.tag = 10027;
    [btnJin addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnYing = [[PetsButton alloc] initWithTitle:@"鹦鹉鱼" nor:@"yingwu" high:@"yingwu" frame:Rect(btnJin.width+btnJin.x+18,6,44,60)];
    [scrolView addSubview:btnYing];
    btnYing.tag = 10002;
    [btnYing addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnLuohan = [[PetsButton alloc] initWithTitle:@"罗汉鱼" nor:@"yingwu" high:@"yingwu" frame:Rect(btnYing.width+btnYing.x+18,6,44,60)];
    [scrolView addSubview:btnLuohan];
    btnLuohan.tag = 10080;
    [btnLuohan addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnShen = [[PetsButton alloc] initWithTitle:@"神仙鱼" nor:@"yingwu" high:@"yingwu" frame:Rect(btnLuohan.width+btnLuohan.x+18,6,44,60)];
    [scrolView addSubview:btnShen];
    btnShen.tag = 10075;
    [btnShen addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    PetsButton *btnHudie = [[PetsButton alloc] initWithTitle:@"蝴蝶鱼" nor:@"yingwu" high:@"yingwu" frame:Rect(btnShen.width+btnShen.x+18,6,44,60)];
    [scrolView addSubview:btnHudie];
    btnHudie.tag = 100178;
    [btnHudie addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    PetsButton *btnOther = [[PetsButton alloc] initWithTitle:@"其它" nor:@"other_yulei" high:@"other_yulei" frame:Rect(btnHudie.width+btnHudie.x+18,6,44,60)];
    [scrolView addSubview:btnOther];
    [btnOther addTarget:self action:@selector(TopViewChange) forControlEvents:UIControlEventTouchUpInside];
    
    scrolView.showsHorizontalScrollIndicator = NO;
    scrolView.showsVerticalScrollIndicator = NO;
    scrolView.contentSize = CGSizeMake(btnOther.width+btnOther.x+15,75);
}

-(void)findFish:(int)nId
{
    __weak MapPetsViewController *__self = self;
    findPets.httpBlock = ^(int nStatus,NSArray *aryPet)
    {
        if (nStatus==1)
        {
            if(aryPet.count==0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [__self.view makeToast:@"没有找到目标"];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   [__self removeAnnotation];
                               });
                [__self.aryNear removeAllObjects];
                [__self.aryNear addObjectsFromArray:aryPet];
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                                   [__self addAnnotation];
                               });
            }
        }
    };
    if (nId==0)
    {
        [findPets requestAllPetLocation:fLat long:fLong];
    }
    else
    {
        [findPets requestPetLocation:fLat long:fLong pet:nId];
    }
}

-(void)clickEvent:(PetsButton*)sender
{
    DLog(@"请求类型:%d",(int)(sender.tag-10000));
    int nId = (int)(sender.tag - 10000);
    __block int __nId = nId;
    __weak MapPetsViewController *__self = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [__self findFish:__nId];
    });
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _aryNear = [NSMutableArray array];
    _aryAnnotation = [NSMutableArray array];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0, [self barSize].height, self.view.width,self.view.height-[self barSize].height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    findPets = [[FindPetsService alloc] init];
    [self startLocation];
    [self initTableView];
    [self initWithScrol];
    [self setRightHidden:NO];
    [self setRightRect:Rect(self.view.width-50, 20, 40, 40)];
    [self setRightImg:@"my_location" high:nil select:nil];
    __weak MapPetsViewController *__self = self;
    [self addRightEvent:^(id sender)
    {
        [__self setMapCenter];
    }];
}

-(void)setMapCenter
{
    if(_mapView)
    {
        CLLocationCoordinate2D coord;
        coord.latitude = fLat;
        coord.longitude = fLong;
        [_mapView setCenterCoordinate:coord animated:YES];
    }
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
    findPets.httpBlock = ^(int nStatus,NSArray *aryInfo)
    {
        DLog(@"aryData_length:%u",aryInfo.count);
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
    [findPets requestAllPetLocation:fLat long:fLong];
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
        [_aryAnnotation addObject:bmk];
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

-(void)dealloc
{
    [_locService stopUserLocationService];
    for (BMKPointAnnotation *point in _mapView.annotations)
    {
        [_mapView removeAnnotation:point];
    }
    _locService = nil;
    findPets = nil;
    bmk_my = nil;
}

#pragma mark 新增加的
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableView) {
        return ((NSArray*)[[PetSort sharedPetSort].aryInfo objectAtIndex:section]).count;
    }
    else
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains [cd] %@",searchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[[PetSort sharedPetSort].petListArr filteredArrayUsingPredicate:predicate]];
        return filterData.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tableView)
    {
        return [PetSort sharedPetSort].aryKey.count;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *strPinYinIdentify = @"pinyinIdentity";
    cell = [tableView dequeueReusableCellWithIdentifier:strPinYinIdentify];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strPinYinIdentify];
    }
    if(tableView == _tableView)
    {
        NSArray *aryValues = [[PetSort sharedPetSort].aryInfo objectAtIndex:indexPath.section];
        PetSortModel *petModel = [aryValues objectAtIndex:indexPath.row];
        cell.textLabel.text = petModel.name;
    }
    else
    {
         cell.textLabel.text = ((PetSortModel *)filterData[indexPath.row]).name;
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView==_tableView)
    {
        return [[PetSort sharedPetSort].aryKey objectAtIndex:section];
    }
    else
    {
        return @"";
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView)
    {
        if(section==0)
        {
            return 30;
        }
        return 20;
    }
    else
    {
        return 20;
    }
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView)
    {
        PetSortModel *pet = [[[PetSort sharedPetSort].aryInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [self findFish:[pet.iD intValue]];
        [self TopViewChange];
    }
    else
    {
        PetSortModel *pet = (PetSortModel*)filterData[indexPath.row];
        [self findFish:[pet.iD intValue]];
        [searchDisplayController setActive:NO];
        topView.hidden = YES;
    }
}

@end
