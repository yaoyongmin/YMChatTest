//
//  YMUtils.h
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMUtils : NSObject


/// 转json
/// @param object 传入的数据
+(NSString *)paramsToJsonData:(id)object;

+ (NSString *)unicodeToString:(NSString *)unicodeJsonString;

/*按照拼音首字母排序*/
+(NSMutableArray*) SortPinYing:(NSMutableArray*)pFriendListArray;

@end
NS_ASSUME_NONNULL_END
