//
//  UserConfig.m
//  ruyiRuyi
//
//  Created by 小马驾驾 on 2018/4/26.
//  Copyright © 2018年 如驿如意. All rights reserved.
//

#import "UserConfig.h"
@implementation UserConfig

+(void)userDefaultsSetObject:(id)object key:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)userDefaultsGetObjectForKey:(NSString *)key{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }else{
        return NULL;
    }
}
+(NSString *)kToken{
    return [self userDefaultsGetObjectForKey:@"token"];
}

+ (NSString *)kIsFirstLoad{
    return [self userDefaultsGetObjectForKey:isFirstLoad];
}

+ (NSString *)kIsLogin{
    return [self userDefaultsGetObjectForKey:isLogin];
}
+ (NSString *)uid{
    return [self userDefaultsGetObjectForKey:loginUid];
}
+ (NSString *)time{
    return [self userDefaultsGetObjectForKey:loginTime];
}
+ (NSString *)key{
    return [self userDefaultsGetObjectForKey:loginKey];
}

@end
