//
//  UserInfo.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UserInfo.h"
#include <math.h>
@implementation UserInfo

DEFINE_SINGLETON_FOR_CLASS(UserInfo);

-(void)setLoginUser:(NSDictionary *)dicInfo
{
    _strUserId = [dicInfo objectForKey:@"userid"];
    _strPassword = [dicInfo objectForKey:@"password"];
    _strMobile = [dicInfo objectForKey:@"mobile"];
    _strNickName = [dicInfo objectForKey:@"nickname"];
    _nSex = [[dicInfo objectForKey:@"sex"] intValue];
    _strBirthday = [dicInfo objectForKey:@"birthday"];
    _strSignature=[dicInfo objectForKey:@"signature"];
    _strUserIcon=[dicInfo objectForKey:@"userIcon"];
    _strFansNum=[dicInfo objectForKey:@"fansNum"];
    _strFocusNum=[dicInfo objectForKey:@"focusNum"];
    _strUserIcon=[dicInfo objectForKey:@"userIcon"];
    _nScore=[[dicInfo objectForKey:@"points"]intValue];
    _nIsOpen=[[dicInfo objectForKey:@"isopen"]intValue];
}

-(double)getDistan:(CLLocationCoordinate2D)dStart end:(CLLocationCoordinate2D)dEnd
{
    double lat1 = (M_PI/180)*dStart.latitude;
    double lat2 = (M_PI/180)*dEnd.latitude;
    
    double lon1 = (M_PI/180)*dStart.longitude;
    double lon2 = (M_PI/180)*dEnd.longitude;
    
    //地球半径
    double R = 6371;
    
    //两点间距离 km，如果想要米的话，结果*1000就可以了
    double d =  acos(sin(lat1)*sin(lat2)+cos(lat1)*cos(lat2)*cos(lon2-lon1))*R;
    
    return d*1000;
}



@end
