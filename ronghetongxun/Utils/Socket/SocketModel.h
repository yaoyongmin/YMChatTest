//
//  SocketModel.h
//  WebSocketRocketTry
//
//  Created by 张建伟 on 17/3/4.
//  Copyright © 2017年 张建伟. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    disConnectByUser ,
    disConnectByServer,
} DDisConnectType;
@interface SocketModel : NSObject

+ (instancetype)share;

///端口
@property (nonatomic, assign) NSInteger kPort;

///服务端ip
@property(nonatomic, copy)NSString *kHost;

///
@property(nonatomic, copy)NSString *kPath;


- (void)connect;

- (void)disConnect;

- (void)sendMsg:(NSString *)msg;

- (void)ping;
@end
