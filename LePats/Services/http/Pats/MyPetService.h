//
//  MyPetService.h
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^MyPetsBlock)(NSString *error,NSArray *data);
@interface MyPetService : HttpManager


-(void)requestPetInfo:(int)nCur;
@property (nonatomic,copy) MyPetsBlock myPetsBlock;

@end
