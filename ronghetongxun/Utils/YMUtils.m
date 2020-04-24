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

@end
