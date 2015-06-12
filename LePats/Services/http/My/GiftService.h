//
//  GiftService.h
//  LePats
//
//  Created by admin on 15/6/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpManager.h"

typedef void(^GiftServiceBlock)(NSString *error,NSArray *data);
@interface GiftService : HttpManager
-(void)requestGiftWithID:(int)nUserId;
@property (nonatomic,copy) GiftServiceBlock giftServiceBlock;
@end
