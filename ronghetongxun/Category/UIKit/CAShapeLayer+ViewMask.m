//
//  CAShapeLayer+ViewMask.m
//  xiongYouIos
//
//  Created by 姚永敏 on 2020/3/12.
//  Copyright © 2020 DeShuai Yu. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"
@implementation CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view{

    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);

    CGFloat rightSpace = 10.f;
    CGFloat topSpace = 10.f;
    CGFloat cuspHeight = 22.f;
    
    ///上右
    CGPoint point1 = CGPointMake(0, topSpace);
    CGPoint point2 = CGPointMake(viewWidth - cuspHeight - rightSpace, topSpace);
    CGPoint point3 = CGPointMake(viewWidth  - cuspHeight/2 -rightSpace , 0);
    CGPoint point4 = CGPointMake(viewWidth  - rightSpace, topSpace);
    CGPoint point5 = CGPointMake(viewWidth, topSpace);
    CGPoint point6 = CGPointMake(viewWidth, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);

    
    ///右上
//    CGPoint point1 = CGPointMake(0, 0);
//    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
//    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
//    CGPoint point4 = CGPointMake(viewWidth, topSpace);
//    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
//    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
//    CGPoint point7 = CGPointMake(0, viewHeight);

    ///上左
    
    ///下右

    ///下左
    
    ///左下
    
    ///左上
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}

@end
