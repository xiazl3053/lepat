//
//  Pet.h
//  LePats
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PetSortModel : NSObject

//@property (nonatomic,copy) NSString *name;
//@property (nonatomic,copy) NSString *type;
//@property (nonatomic,copy) NSString *age;
//@property (nonatomic,copy) NSString *sex;
//@property (nonatomic,copy) NSString *desc;
//@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *iD;
@property (nonatomic,copy) NSString *modtime;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *superId;

-(id)initWithNSDictionary:(NSDictionary *)dic;


@end
