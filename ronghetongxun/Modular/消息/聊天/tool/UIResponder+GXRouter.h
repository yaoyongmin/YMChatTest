//
//  UIResponder+GXRouter.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/17.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GXRouter)


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
