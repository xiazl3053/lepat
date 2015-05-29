//
//  EditNickViewController.h
//  LePats
//
//  Created by admin on 15/5/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    MYInfoEdit_TYPE_NickName,
    MYInfoEdit_TYPE_Signture,
    MYInfoEdit_TYPE_Sex,
} MYInfoEdit_TYPE;

@interface EditMyInfoViewController : BaseViewController
@property (nonatomic,assign) MYInfoEdit_TYPE editType;

@end
