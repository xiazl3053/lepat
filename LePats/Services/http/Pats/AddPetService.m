//
//  AddPetService.m
//  LePats
//
//  Created by 夏钟林 on 15/5/13.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AddPetService.h"
#import "UserInfo.h"

@implementation AddPetService

-(void)requestAddPet:(LePetInfo*)lePet
{
    UserInfo *user = [UserInfo sharedUserInfo];
//    NSString *strName = [NSString stringWithUTF8String:"ting"];
//    NSString *strDecription = [NSString stringWithUTF8String:"ting"];
    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/doAdd.do",LEPAT_HTTP_HOST];
    
//    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/doAdd.do?petName=%@&petCount=%d&birthday=%@&sortId=%d&photoid=%d&description=%@&sex=%d&userid=%@&token=%@%@",LEPAT_HTTP_HOST,lePet.strName,lePet.nPetCount,lePet.strBirthday,lePet.nSortId,lePet.nPhotoId,lePet.strDescription,lePet.nSex,
//                        user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    
    NSString *post = [NSString stringWithFormat:@"petName=%@&petCount=%d&birthday=%@&sortId=%d&photoid=%d&description=%@&sex=%d&userid=%@&token=%@%@",lePet.strName,lePet.nPetCount,lePet.strBirthday,lePet.nSortId,lePet.nPhotoId,lePet.strDescription,lePet.nSex,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    NSData *data = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [self sendRequestData:data url:strUrl];
    
//    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"添加我的宠物错误");
        return ;
    }
    DLog(@"dic:%@",dic);
}

@end
