//
//  ICChatServerDefs.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#ifndef ICChatServerDefs_h
#define ICChatServerDefs_h

// 消息发送状态
typedef enum {
    ICMessageDeliveryState_Pending = 0,  // 待发送
    ICMessageDeliveryState_Delivering,   // 正在发送
    ICMessageDeliveryState_Delivered,    // 已发送，成功
    ICMessageDeliveryState_Failure,      // 发送失败
    ICMessageDeliveryState_ServiceFaid   // 发送服务器失败(可能其它错,待扩展)
}MessageDeliveryState;


typedef enum {
    ICGroup_SELF = 0,                    // 自己
    ICGroup_DOUBLE,                      // 双人组
    ICGroup_MULTI,                       // 多人组
    ICGroup_NOTIFY,                      // 通知
    ICGroup_BOOK                         // 通讯录
}ICGroupType;

// 消息状态
typedef enum {
    ICMessageStatus_unRead = 0,          // 消息未读
    ICMessageStatus_read,                // 消息已读
    ICMessageStatus_back                 // 消息撤回
}ICMessageStatus;

typedef enum {
    ICActionType_READ = 1,               // 语音已读
    ICActionType_BACK,                   // 消息撤回
    ICActionType_UPTO,                   // 消息读数
    ICActionType_KICK,                   // 请出会话
    ICActionType_OPOK,                   // 待办已办
    ICActionType_BDRT,                   // 送达号消息撤回
    ICActionType_GUPD,                   // 群信息修改
    ICActionType_UUPD,                   // 群成员信息修改
    ICActionType_DUPD,                   // 送达号信息修改
    ICActionType_OFFL = 10,              // 请您下线
    ICActionType_STOP = 11,              // 清除所有缓存
    ICActionType_UUPN                    // 改昵称

}ICActionType;


typedef enum {
    ICDeliverTopStatus_NO         = 0, // 非置顶
    ICDeliverTopStatus_YES             // 置顶
}ICDeliverTopStatus;
#import "ICMessageConst.h"


#endif /* ICChatServerDefs_h */
