//
//  NSString+XY.h
//  xiongYouIos
//
//  Created by 姚永敏 on 2020/3/11.
//  Copyright © 2020 DeShuai Yu. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XY)

/**
 手机号格式检查并提示
 @return YES正确 NO错误
 */
+ (BOOL)phoneFormatCheck:(NSString *)string;


/**
 密码格式判断 6~20 必须包含数字或者字母
 @return YES正确 NO错误
 */
+ (BOOL)passFormatCheck:(NSString *)string;


/**
 身份证号格式检查并提示
 @return YES正确 NO错误
 */
+ (BOOL)idFormatCheck:(NSString *)string;


/**
 邮箱格式检查并提示
 @return YES正确 NO错误
 */
+ (BOOL)emailFormatCheck:(NSString *)string;


/**
 银行卡号格式检查并提示
 @return YES正确 NO错误
 */
+ (BOOL)bankCardFormatCheck:(NSString *)string;


/**
 中文姓名格式检查并提示
 @return YES正确 NO错误
 */
+ (BOOL)cnNameFormatCheck:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
