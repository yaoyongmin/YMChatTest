//
//  AppDelegate+Configure.m
//  xiongYouIos
//
//  Created by 姚永敏 on 2020/3/9.
//  Copyright © 2020 DeShuai Yu. All rights reserved.
//

#import "AppDelegate+Configure.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "SocketModel.h"
@implementation AppDelegate (Configure)

- (void)configure {
    [self configureIQKeyBoard];
    [self configureSocket];
}

/// IQKeyboardManager
-(void)configureIQKeyBoard{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
//    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
}

///socket configure
- (void)configureSocket{
    
    [[SocketModel share] setKHost:@"127.0.0.1"];
    [[SocketModel share] setKPort:6969];
    [[SocketModel share] setKPath:@""];

}
@end
