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
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSURL *url=[NSURL URLWithString:[strPath stringByAddingPercentEscapesUsingEncoding:enc]];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:XC_HTTP_TIMEOUT];//设置超时时间
    [request setHTTPMethod:@"POST"];//设置请求方式
    
    __block HttpManager *weakSelf = self;
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
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (responseCode == 200)
    {
        int nStatus = [[dic objectForKey:@"return_code"] intValue];
        if (nStatus == 50003)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_SHOW_LOGIN_VC object:nil];
            return ;
        }
    }
    [self reciveDic:(int*)&responseCode dic:dic];
}

-(BOOL)isConnection:(NSDictionary *)dict
{
    int nCode = [[dict objectForKey:@"return_code"] intValue];
    if (nCode == 50003)
    {
        return YES;
    }
    return NO;
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dict
{

}

-(void)decodeJson:(NSData*)jsonData
{
    
}

-(void)sendRequestData:(NSData*)data url:(NSString *)strUrl
{
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:XC_HTTP_TIMEOUT];//设置超时时间
    [request setHTTPMethod:@"POST"];//设置请求方式
    [request setHTTPBody:data];
    
    __block HttpManager *weakSelf = self;
    DLog(@"strPath:%@",strUrl);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError){
         HttpManager *strongLogin = weakSelf;
         if (strongLogin)
         {
             [strongLogin reciveHttp:response data:data error:connectionError];
         }
    }];
}

-(void)sendRequestString:(NSString *)strInfo url:(NSString *)strUrl
{
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];//通过URL创建网络请求
    [request setTimeoutInterval:XC_HTTP_TIMEOUT];//设置超时时间
    [request setHTTPMethod:@"POST"];//设置请求方式
    NSData *data = [strInfo dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:data];
    __block HttpManager *weakSelf = self;
    
    DLog(@"strPath:%@",strUrl);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError){
         HttpManager *strongLogin = weakSelf;
         if (strongLogin)
         {
             [strongLogin reciveHttp:response data:data error:connectionError];
         }
     }];
}


@end
