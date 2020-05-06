//
//  ICMessage.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseModel.h"
#import "ICChatServerDefs.h"
NS_ASSUME_NONNULL_BEGIN

@interface ICMessage : BaseModel


// 消息来源用户名
@property (nonatomic, copy) NSString *senderName;
// 消息来源用户id
@property (nonatomic, copy) NSString *from;
// 消息目的地群组id
@property (nonatomic, copy) NSString *to;
// 消息ID
@property (nonatomic, copy) NSString *messageId;
// 消息发送状态
@property (nonatomic, assign) MessageDeliveryState deliveryState;
// 消息时间
@property (nonatomic, assign) NSInteger date;
// 系统发出的消息，时间字符串
@property (nonatomic, copy) NSString *sendDate;
// 本地消息标识:(消息+时间)的MD5
@property (nonatomic, copy) NSString *localMsgId;
// 消息文本内容
@property (nonatomic, copy) NSString *content;
// 消息图片地址
@property (nonatomic, copy) NSString *imagePath;
// 消息图片
@property (nonatomic, copy) UIImage *image;
// 视频地址
@property (nonatomic, copy) NSString *videoPath;
//音频地址
@property (nonatomic, copy) NSString *voicePath;
// 音频文件的fileKey
@property (nonatomic, copy) NSString *fileKey;
// 发送消息对应的type类型:1,2,3
@property (nonatomic, copy) NSString *type;
// 时长，宽高，首帧id
@property (nonatomic, strong) NSString *lnk;

@property (nonatomic, assign)BOOL isSender;

@end

NS_ASSUME_NONNULL_END
