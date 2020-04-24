//
//  ChatMoreView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatMoreView;
NS_ASSUME_NONNULL_BEGIN

@protocol ChatMoreViewDelegate <NSObject>

- (void)ChatMoreView:(ChatMoreView *)moreView didSelectRowAtIndex:(NSInteger)index;

@end

@interface ChatMoreView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;

- (void)show;
- (void)dismiss;

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *shotView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) id<ChatMoreViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
