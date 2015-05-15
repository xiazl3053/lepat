//
//  HttpUploadManager.m
//  LePats
//
//  Created by 夏钟林 on 15/5/14.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HttpUploadManager.h"
#import "UserInfo.h"



#define BOUNDARY @"----------cH2gL6ei4Ef1KM7cH2KM7ae0ei4gL6"

@implementation HttpUploadManager




#pragma mark 主页
-(void)uploadPersonHome:(UIImage *)image
{
    [self uploadInfo:image content:@"user_home" objId:[UserInfo sharedUserInfo].strUserId];
}


#pragma mark
-(void)uploadPet:(UIImage *)image petId:(NSString *)strId
{
    [self uploadInfo:image content:@"pat_img" objId:strId];
}

-(void)uploadPetHead:(UIImage*)image petId:(NSString *)strId
{
    [self uploadInfo:image content:@"pat_icon" objId:strId];
}

-(void)uploadPersonHead:(UIImage *)image
{
    [self uploadInfo:image content:@"user_img" objId:[UserInfo sharedUserInfo].strUserId];
}

-(void)uploadPerson:(UIImage *)image
{
    [self uploadInfo:image content:@"user_icon" objId:[UserInfo sharedUserInfo].strUserId];
}

-(void)uploadInfo:(UIImage*)image content:(NSString *)strContent objId:(NSString *)strId
{
    UserInfo *user = [UserInfo sharedUserInfo];
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@pats/photo/upload.do?objid=%@&objtype=%@&userid=%@&token=%@%@",
                        LEPAT_HTTP_HOST,strId,strContent,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    NSData *imageData = UIImageJPEGRepresentation(image,0.9);
    NSString *strPath = [NSTemporaryDirectory() stringByAppendingString:@"avatar.jpg"];
    
    [imageData writeToFile:strPath atomically:YES];
    
    FileDetail *file = [FileDetail fileWithName:strPath data:imageData];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:file,@"imageFile",nil];
    [self upload:strUrl widthParams:params];
}

-(void)upload:(NSString *)url widthParams:(NSDictionary *)params
{
    
    NSMutableURLRequest *myRequest = [ [NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    for(NSString *key in params)
    {
        id content = [params objectForKey:key];
        if ([content isKindOfClass:[NSString class]] || [content isKindOfClass:[NSNumber class]])
        {
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,key,content,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([content isKindOfClass:[FileDetail class]])
        {
            FileDetail *file = (FileDetail *)content;
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,key,file.name,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file.data];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSString *endString = [NSString stringWithFormat:@"--%@--",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequest setHTTPBody:body];
    __block HttpUploadManager *weakSelf = self;
    DLog(@"strUrl:%@",myRequest.URL);
    [NSURLConnection sendAsynchronousRequest:myRequest queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         HttpUploadManager *strongLogin = weakSelf;
         if (strongLogin)
         {
             [strongLogin reciveLoginInfo:response data:data error:connectionError];
         }
     }];
}

#if 0
-(void)upload:(NSString *)url widthParams:(NSDictionary *)params
{
    
    NSMutableURLRequest *myRequest = [ [NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:0];
    [myRequest setHTTPMethod:@"POST"];
    [myRequest setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    for(NSString *key in params)
    {
        id content = [params objectForKey:key];
        if ([content isKindOfClass:[NSString class]] || [content isKindOfClass:[NSNumber class]])
        {
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,key,content,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([content isKindOfClass:[FileDetail class]])
        {
            FileDetail *file = (FileDetail *)content;
            NSString *param = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,key,file.name,nil];
            [body appendData:[param dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:file.data];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSString *endString = [NSString stringWithFormat:@"--%@--",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequest setHTTPBody:body];
    __block HttpUploadManager *weakSelf = self;
    DLog(@"strUrl:%@",myRequest.URL);
    [NSURLConnection sendAsynchronousRequest:myRequest queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         HttpUploadManager *strongLogin = weakSelf;
         if (strongLogin)
         {
             [strongLogin reciveLoginInfo:response data:data error:connectionError];
         }
     }];
}
#endif




-(void)reciveLoginInfo:(NSURLResponse*) response data:(NSData*)data error:(NSError*)connectionError
{
    NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
    if (!connectionError && responseCode == 200)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        DLog(@"dic:%@",dic);
    }
    else
    {
        DLog(@"responseCode:%d",(int)responseCode);
    }
}

@end

@implementation FileDetail

+(FileDetail *)fileWithName:(NSString *)name data:(NSData *)data
{
    FileDetail *file = [[self alloc] init];
    file.name = name;
    file.data = data;
    return file;
}

@end