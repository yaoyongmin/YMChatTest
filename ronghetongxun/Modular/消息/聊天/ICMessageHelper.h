//
//  ICMessageHelper.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICMessage.h"
NS_ASSUME_NONNULL_BEGIN

@interface ICMessageHelper : NSObject

/**
 *  创建一条文本消息
 *  可能是我发送的 也可能是接收到的消息
 *
 *  @param type    消息类型
 *  @param content 文本消息内容
 *  @param from 发送者
 *  @param to 接收者 组 双人聊天 双人组 多人多人组
 *  @return 文本消息
 */
+ (ICMessage *)createMessageModel:(NSString *)type
                          content:(NSString *)content
                             path:(nullable NSString *)path
                             from:(NSString *)from
                               to:(NSString *)to
                          fileKey:(nullable NSString *)fileKey
                         isSender:(BOOL)isSender;
///创建一条图片消息
+ (ICMessage *)createImageMessageModel:(NSString *)type
                             image:(UIImage *)image
                             from:(NSString *)from
                               to:(NSString *)to
                         isSender:(BOOL)isSender;

///创建一条图片消息
+ (ICMessage *)createVideoMessageModel:(NSString *)type
                          videoUrlPath:(NSString *)path
                                  from:(NSString *)from
                                    to:(NSString *)to
                              isSender:(BOOL)isSender;


///创建一条系统时间消息
+ (ICMessage *)createDateMessageModel:(NSString *)type
                                 date:(NSString *)date
                                 from:(NSString *)from
                                   to:(NSString *)to;
@end

NS_ASSUME_NONNULL_END
