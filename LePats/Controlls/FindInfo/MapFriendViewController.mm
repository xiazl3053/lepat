//
//  FriendViewController.m
//  LePats
//
//  Created by xiongchi on 15-5-17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MapFriendViewController.h"
#import "BMKLocationComponent.h"
#import "Toast+UIView.h"
#import "PetsButton.h"
#import "TheyMainViewController.h"
#import "NearInfo.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "FindService.h"
#import "BDMarker.h"
#import "BMapKit.h"
#import "UserInfo.h"
#import "FindPetsService.h"
#import "PetSort.h"
#import "PetSortModel.h"

@interface MapFriendViewController()<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BMKLocationService *_locService;
    CGFloat fLat,fLong;
    FindService *findSer;
    BMKPointAnnotation *bmk_my;
    BDMarker *bdMarker;
    BOOL bMeLoading;
    BOOL bTheLoading;
    UIScrollView *scrolView;
    FindPetsService *findPets;
    UIView *topView;
    NSArray *filterData;
    UISearchDisplayController *searchDisplayController;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *aryAnnotation;
@property (nonatomic,strong) NSMutableArray *aryNear;
@end

@implementation MapFriendViewController

-(void)initTableView
{
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
    __weak MapFriendViewController *__self = self;
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
    [findPets requestPetLocation:fLat long:fLong pet:nId];
}

-(void)clickEvent:(PetsButton*)sender
{
    DLog(@"请求类型:%d",(int)(sender.tag-10000));
    int nId = (int)(sender.tag - 10000);
    __block int __nId = nId;
    __weak MapFriendViewController *__self = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [__self findFish:__nId];
    });
}

-(id)initWithLat:(CGFloat)fLatitude long:(CGFloat)fLongitude
{
    self = [super init];
    fLat = fLatitude;
    fLong = fLongitude;
    return self;
}

-(id)init
{
    self = [super init];
    fLat = 0;
    fLong = 0;
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _aryNear = [NSMutableArray array];
    _aryAnnotation = [NSMutableArray array];
    findSer = [[FindService alloc] init];
    findPets = [[FindPetsService alloc] init];
    _mapView = [[BMKMapView alloc] initWithFrame:Rect(0,[self barSize].height, kScreenSourchWidth, kScreenSourchHeight-64)];
    self.title = @"地图";
    _mapView.delegate = self;
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
    [self initWithScrol];
    [self initTableView];
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
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    DLog(@"11111");
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
            imgView.tag = bMark.nIndex;
            [imgView setUserInteractionEnabled:YES];
            [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagTheyInfo:)]];
            newAnnotationView.leftCalloutAccessoryView = view;
            DLog(@"bMark:%@",bMark.near);
        }
        return newAnnotationView;
    }
    return nil;
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

-(void)loadImageView:(UIImage *)image
{
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
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
    NSInteger nCount = _aryNear.count;
    for(int i=0; i< nCount ;i++ )
    {
        NearInfo *near = [_aryNear objectAtIndex:i];
        BDMarker *bmk = [[BDMarker alloc] init];
        bmk.nIndex = i;
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
    if(fLat == 0 && fLong == 0)
    {
        fLat = userLocation.location.coordinate.latitude;
        fLong = userLocation.location.coordinate.longitude;
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
}

-(void)addFriend
{
    DLog(@"aryNear:%@",_aryNear);
}

-(void)dealloc
{
    [_locService stopUserLocationService];
    for (BMKPointAnnotation *point in _mapView.annotations)
    {
        [_mapView removeAnnotation:point];
    }
    _locService = nil;
    findSer = nil;
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
