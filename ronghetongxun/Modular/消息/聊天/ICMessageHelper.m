//
//  ICMessageHelper.m
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ICMessageHelper.h"

@implementation ICMessageHelper

+ (ICMessage *)createMessageModel:(NSString *)type content:(NSString *)content path:(NSString *)path from:(NSString *)from to:(NSString *)to fileKey:(NSString *)fileKey isSender:(BOOL)isSender{
    
    ICMessage *message    = [[ICMessage alloc] init];
    message.content       = content;
    message.to            = to;
    message.from          = from;
    message.fileKey       = fileKey;
    message.isSender      = isSender;
    message.type          = [NSString stringWithFormat:@"%@_%@",type, isSender ? @"right" : @"left"];
    if (isSender) {///是当前发送者 初始状态为 正在发生  发送成功或失败后 修改状态
        message.deliveryState = ICMessageDeliveryState_Delivering;
    } else {///接收到的消息 非当前发送者
        message.deliveryState = ICMessageDeliveryState_Delivered;
    }
    
    return message;
}

+ (ICMessage *)createImageMessageModel:(NSString *)type image:(UIImage *)image from:(NSString *)from to:(NSString *)to isSender:(BOOL)isSender{
    
    ICMessage *message  = [[ICMessage alloc] init];
    message.image       = image;
    message.to          = to;
    message.from        = from;
    message.isSender    = isSender;
    message.type        = [NSString stringWithFormat:@"%@_%@",type, isSender ? @"right" : @"left"];
    if (isSender) {
        message.deliveryState = ICMessageDeliveryState_Delivering;
    } else {
        message.deliveryState = ICMessageDeliveryState_Delivered;
    }
    return message;
}

+ (ICMessage *)createVideoMessageModel:(NSString *)type videoUrlPath:(NSString *)path from:(NSString *)from to:(NSString *)to isSender:(BOOL)isSender{
    
    ICMessage *message  = [[ICMessage alloc] init];
    message.videoPath   = path;
    message.to          = to;
    message.from        = from;
    message.isSender    = isSender;
    message.type        = [NSString stringWithFormat:@"%@_%@",type, isSender ? @"right" : @"left"];
    if (isSender) {
        message.deliveryState = ICMessageDeliveryState_Delivering;
    } else {
        message.deliveryState = ICMessageDeliveryState_Delivered;
    }
    return message;
}

+ (ICMessage *)createDateMessageModel:(NSString *)type date:(NSString *)date from:(NSString *)from to:(NSString *)to{
    
    ICMessage *message  = [[ICMessage alloc] init];
    message.sendDate    = date;
    message.to          = to;
    message.from        = from;
    message.type        = [NSString stringWithFormat:@"%@",type];
    
    return message;
}
@end
