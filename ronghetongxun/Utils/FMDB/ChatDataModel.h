//
//  ChatDataModel.h
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatDataModel : NSObject

@property (nonatomic, assign)NSNumber *chatID;
@property (nonatomic, assign)NSNumber *chatRowID;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *photoURL;
@property (nonatomic, copy)NSString *videoURL;

@end

NS_ASSUME_NONNULL_END
