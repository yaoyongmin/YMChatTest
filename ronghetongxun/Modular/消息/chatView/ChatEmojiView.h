//
//  ChatEmojiView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/16.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatEmojiView;
NS_ASSUME_NONNULL_BEGIN

@protocol ChatEmojiDelegate <NSObject>

///选择表情
- (void)ChatEmojiView:(ChatEmojiView *)emojiView didSelectEmojiItemAtText:(NSString *)emojiText;

///点击发送按钮
- (void)ChatEmojiViewClickSendButtonAction;

@end

@interface ChatEmojiView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *emojiCollectionView;

@property (nonatomic, strong)UIButton *sendBtn;

@property (nonatomic, strong)NSArray *allEmoji;

@property (nonatomic, weak)id <ChatEmojiDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
