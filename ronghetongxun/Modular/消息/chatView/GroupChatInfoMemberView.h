//
//  GroupChatInfoMemberView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+GXRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupChatInfoMemberView : UIView

///群聊信息  成员视图

- (void)setMembersData:(NSArray *)members;

@end

NS_ASSUME_NONNULL_END
