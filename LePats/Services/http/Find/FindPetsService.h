//
//  FindPetsService.h
//  LePats
//
//  Created by xiongchi on 15-6-4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^HttpPetBlock)(int nStatus,NSArray *aryPet);

@interface FindPetsService : HttpManager

@property (nonatomic,copy) HttpPetBlock httpBlock;

-(void)requestPetLocation:(CGFloat)fLat long:(CGFloat)fLng;

-(void)requestPetLocation:(CGFloat)fLat long:(CGFloat)fLng pet:(int)nPet;


@end
