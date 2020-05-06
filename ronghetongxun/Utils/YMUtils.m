//
//  YMUtils.m
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMUtils.h"

@implementation YMUtils

+(NSString *)paramsToJsonData:(id)object{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSLog(@"JSON:%@",mutStr);
    return mutStr;
}

+ (NSString *)unicodeToString:(NSString *)unicodeJsonString{
    const char *jsonString = [unicodeJsonString UTF8String]; // Emoji表情编解码
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *goodMsg1 = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return goodMsg1;
}

/*按照拼音首字母排序*/
+(NSMutableArray*) SortPinYing:(NSMutableArray*)pFriendListArray
{
    
    NSMutableArray* pAllArray = [[NSMutableArray alloc] init];
    for(char sz = 'A'; sz <= 'Z'; ++sz)
    {
        NSMutableArray* pArray = [[NSMutableArray alloc] init];
        for(int i = 0;i < pFriendListArray.count; ++i)
        {
            NSMutableDictionary *memeber = [pFriendListArray objectAtIndex:i];
            
            NSString* pPinYin = [self FirstCharactor:memeber[@"name"]];
            if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
            {
                [pArray addObject:memeber];
            }
        }
        
        while(true)
        {
            int i = 0;
            for(;i < pFriendListArray.count; ++i)
            {
                NSMutableDictionary *memeber = [pFriendListArray objectAtIndex:i];

                NSString* pPinYin = [self FirstCharactor:memeber[@"name"]];
                if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
                {
                    [pFriendListArray removeObjectAtIndex:i];
                    break;
                }
            }
            
            if(i == pFriendListArray.count)
            {
                if(pArray.count > 0)
                {
                    NSMutableDictionary *memeber = [pFriendListArray objectAtIndex:i];
                    memeber[@"userID"] = @"-1";
                    memeber[@"name"] = [NSString stringWithFormat:@"%c", sz];
                    
                    [pAllArray addObject:memeber];
                    [pAllArray addObjectsFromArray:pArray];
                }
                
                break;
            }
        }
    }
    
    if (pFriendListArray.count != 0) {
        NSMutableDictionary *memeber = [NSMutableDictionary dictionary];
        memeber[@"userID"] = @"-1";
        memeber[@"name"] = @"#";
        [pAllArray addObject:memeber];
        [pAllArray addObjectsFromArray:pFriendListArray];
    }
    return pAllArray;
    
}

//CommonUtil里面的类方法：
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+(NSString *)FirstCharactor:(NSString *)pString
{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}


- (void)configWorkView:(UIView *)view{
    ///阴影圆角共存
    view.clipsToBounds = NO;
    view.layer.cornerRadius = 5.f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(1,1);
    view.layer.shadowRadius = 4;
    view.layer.shadowOpacity = 0.2;
}
@end
