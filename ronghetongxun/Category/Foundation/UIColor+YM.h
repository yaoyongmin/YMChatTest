//
//  UIColor+YM.h
//  YeMai
//
//  Created by yym on 2020/4/9.
//  Copyright © 2020 jacob. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 16进制颜色 */
static inline UIColor *YMHexColor(NSUInteger hexValue) {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0];
}
/** RGBA颜色 */
static inline UIColor *YMRGBA(float r, float g, float b, float a) {
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a];
}

/** RGBA颜色 */
static inline UIColor *YMRGB(float r, float g, float b) {
    return YMRGBA(r, g, b, 1);
}


@interface UIColor (YM)

///16进制颜色
+ (instancetype)ym_colorFromHexString:(NSString *)hexStr;
///alpha
+ (instancetype)ym_colorFromHexString:(NSString *)hexStr withAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
