//
//  DBRecorder.h
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DBRecorder : NSObject

/// 插入聊天数据
+ (void)insertChatData:(ChatDataModel *)charData;

/// 删除聊天记录
/// @param charID  与谁聊天id
+ (void)deleChatDataWith:(nonnull id)charID;

/// 获取聊天记录数据
/// @param chatID 聊天ID
+ (NSArray <ChatDataModel *>*)getChatData:(nonnull id)chatID;

@end

NS_ASSUME_NONNULL_END
