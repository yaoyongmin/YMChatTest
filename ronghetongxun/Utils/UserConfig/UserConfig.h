//
//  UserConfig.h
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserConfigKey.h"
@interface UserConfig : NSObject


+ (void)userDefaultsSetObject:(id)object key:(NSString *)key;

+ (id)userDefaultsGetObjectForKey:(NSString *)key;

+ (NSString *)kToken;

+ (NSString *)kIsFirstLoad;

+ (NSString *)kIsLogin;

+ (NSString *)uid;

+ (NSString *)time;

+ (NSString *)key;

@end
