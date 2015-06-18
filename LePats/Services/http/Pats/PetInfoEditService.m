//
//  PetInfoEditService.m
//  LePats
//
//  Created by admin on 15/5/25.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetInfoEditService.h"
#import "UserInfo.h"
@implementation PetInfoEditService

-(void)requestEditPet:(LePetInfo *)lePet{
    UserInfo *user = [UserInfo sharedUserInfo];
    //    NSString *strName = [NSString stringWithUTF8String:"ting"];
    //    NSString *strDecription = [NSString stringWithUTF8String:"ting"];
    NSString *strUrl = [NSString stringWithFormat:@"%@pets/pet/doEdit.do",LEPAT_HTTP_HOST];
    
    //    NSString *strUrl = [NSString stringWithFormat:@"%@pats/pet/doAdd.do?petName=%@&petCount=%d&birthday=%@&sortId=%d&photoid=%d&description=%@&sex=%d&userid=%@&token=%@%@",LEPAT_HTTP_HOST,lePet.strName,lePet.nPetCount,lePet.strBirthday,lePet.nSortId,lePet.nPhotoId,lePet.strDescription,lePet.nSex,
    //                        user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    
    NSString *post = [NSString stringWithFormat:@"petId=%d&petName=%@&petCount=%d&birthday=%@&sortId=%d&description=%@&sex=%d&userid=%@&token=%@%@",lePet.nPetId,lePet.strName,lePet.nPetCount,lePet.strBirthday,lePet.nSortId,lePet.strDescription,lePet.nSex,user.strUserId,user.strToken,LEPAT_VERSION_INFO];
    //    NSData *data = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //    [self sendRequestData:data url:strUrl];
    [self sendRequestString:post url:strUrl];
    //    [self sendRequest:strUrl];
}

-(void)reciveDic:(int *)nStatus dic:(NSDictionary *)dic
{
    if (*nStatus!=200)
    {
        DLog(@"编辑我的宠物错误");
        if (self.editPetBlock)
        {
            self.editPetBlock(KLinkServiceErrorMsg);
        }
        return ;
    }
    DLog(@"dic:%@",dic);
    if (self.editPetBlock) {
        if ([[dic objectForKey:KServiceResponseCode]intValue]==KServiceResponseSuccess) {
            self.editPetBlock(nil);
        }else{
            self.editPetBlock([dic objectForKey:KServiceResponseMsg]);
        }
    }
}


@end
