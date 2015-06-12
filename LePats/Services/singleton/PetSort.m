//
//  PetSort.m
//  LePats
//
//  Created by admin on 15/6/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "PetSort.h"
#import "PetSortModel.h"
#import "ChineseString.h"
#import "pinyin.h"

@implementation PetSort

DEFINE_SINGLETON_FOR_CLASS(PetSort);

-(void)setPetListArr:(NSArray *)petListArr
{
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[petListArr count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.petSon = (PetSortModel *)[petListArr objectAtIndex:i];
        chineseString.string=[NSString stringWithString:((PetSortModel *)[petListArr objectAtIndex:i]).name];
        if(chineseString.string==nil)
        {
            chineseString.string=@"";
        }
        if(![chineseString.string isEqualToString:@""])
        {
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++)
            {
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin=pinYinResult;
        }
        else
        {
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    //Step3:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    //Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来
    if (_petListArr==nil)
    {
        _petListArr = [NSMutableArray array];
    }
    else
    {
        [_petListArr removeAllObjects];
    }
    for(int i=0;i<[chineseStringsArray count];i++)
    {
        [_petListArr addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).petSon];
    }
    //Step4输出
    NSLog(@"\n\n\n最终结果:");
    for(int i=0;i<[_petListArr count];i++)
    {
        NSLog(@"%@",((PetSortModel*)[_petListArr objectAtIndex:i]).name);
    }
    __weak PetSort *__self = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [__self splitArray];
    });
}

-(NSString *)getPetNameWithiD:(int)iD{
    for (PetSortModel *model in _petListArr)
    {
        if ([model.iD intValue]==iD)
        {
            return model.name;
        }
    }
    return @"";
}

-(void)splitArray
{
    if (_aryInfo==nil)
    {
        _aryInfo = [NSMutableArray array];
        _aryKey = [NSMutableArray array];
    }
    else
    {
        [_aryKey removeAllObjects];
        [_aryInfo removeAllObjects];
    }
    int nTemp = 0;
    for (int i=0; i<26; i++)
    {
        NSMutableArray *arySon = [NSMutableArray array];
        while(nTemp<_petListArr.count &&
              pinyinFirstLetter([((PetSortModel*)[_petListArr objectAtIndex:nTemp]).name characterAtIndex:0])
              == [ALPHA_SMALL characterAtIndex:i])
        {
            [arySon addObject:[_petListArr objectAtIndex:nTemp]];
            nTemp++;
        }
        if (arySon.count >=1 )
        {
            NSString *strKey = [[NSString stringWithFormat:@"%c",[ALPHA characterAtIndex:i]] uppercaseString];
//            [_petDict setValue:arySon forKey:strKey];
            [_aryKey addObject:strKey];
            [_aryInfo addObject:arySon];
        }
    }
}


@end
