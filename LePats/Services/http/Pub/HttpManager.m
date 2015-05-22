//
//  HttpManager.m
//  XCMonit_Ip
//
//  Created by 夏钟林 on 15/3/6.
//  Copyright (c) 2015年 夏钟林. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

-(void)sendRequest:(NSString *)strPath
{
//    [NSString stringWithUTF8String:[strPath UTF8String]]
    NSURL *url=[NSURL URLWithString:[NSString stringWithUTF8String:[strPath UTF8String]]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:XC_HTTP_TIMEOUT];//设置超时时间
    [request setHTTPMethod:@"POST"];//设置请求方式
    __block HttpManager *weakSelf = self;
    DLog(@"strPath:%@",strPath);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError){
         HttpManager *strongLogin = weakSelf;
         if (strongLogin)
         {
             [strongLogin reciveHttp:response data:data error:connectionError];
         }
     }];
}

-(void)reciveHttp:(NSURLResponse *)response data:(NSData*)data error:(NSError*)connectionError
{
    NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
    DLog(@"responseCode:%li",responseCode);
    //准备做加解密
    if (responseCode==200)
    {
   //     [self reciveInfo:(int*)&responseCode data:data];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        [self reciveDic:(int*)&responseCode dic:dic];
    }
    else
    {
        [self reciveDic:(int *)&responseCode dic:nil];
    }
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{
    
}

-(void)decodeJson:(NSData*)jsonData
{
    
}




@end
