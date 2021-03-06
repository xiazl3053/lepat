//
//  HttpUploadManager.h
//  LePats
//
//  Created by 夏钟林 on 15/5/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpLoadImgBlock)(NSString *error,NSDictionary *data);

typedef void(^UpDatePersonIconBlock)(NSString *error);

@interface HttpUploadManager : NSObject

-(void)uploadPersonHome:(UIImage *)image;
-(void)uploadPerson:(UIImage *)image;
-(void)uploadPersonHead:(UIImage *)image;
-(void)uploadPet:(UIImage *)image petId:(NSString *)strId;
-(void)uploadPetHead:(UIImage*)image petId:(NSString *)strId;
@property (nonatomic,copy) UpLoadImgBlock uploadImgBlock;
@property (nonatomic,copy) UpDatePersonIconBlock upDatePersonIconBlock;
@end

@interface FileDetail : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSData *data;

+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data;

@end