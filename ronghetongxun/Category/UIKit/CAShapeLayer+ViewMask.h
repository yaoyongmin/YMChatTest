//
//  CAShapeLayer+ViewMask.h
//  xiongYouIos
//
//  Created by 姚永敏 on 2020/3/12.
//  Copyright © 2020 DeShuai Yu. All rights reserved.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UIViewTriangleDirection) {
    UIViewTriangleDirectionTopLeft,     //上左
    UIViewTriangleDirectionTopRight,    //上右
    UIViewTriangleDirectionLeftTop,     //左上
    UIViewTriangleDirectionLeftBottom,  //左下
    UIViewTriangleDirectionRightTop,    //右上
    UIViewTriangleDirectionRightBottom, //右下
    UIViewTriangleDirectionBottomLeft,  //下左
    UIViewTriangleDirectionBottomRight, //下右
};

@interface CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
