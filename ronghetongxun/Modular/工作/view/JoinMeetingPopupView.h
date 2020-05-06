//
//  JoinMeetingPopupView.h
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JoinMeetingPopupView;
NS_ASSUME_NONNULL_BEGIN

@protocol JoinMeetingPopupViewDelegate <NSObject>

- (void)joinMeetingPopupViewWithConfirmAction:(NSString *)password;

@end

@interface JoinMeetingPopupView : UIView

@property (nonatomic, weak) id<JoinMeetingPopupViewDelegate>delegate;

- (void)show:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
