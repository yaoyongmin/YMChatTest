//
//  LaunchMeetingModel.h
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LaunchMeetingModel : BaseModel

@property (nonatomic, copy)NSString *themeText;
@property (nonatomic, copy)NSString *startTime;
@property (nonatomic, copy)NSString *endTime;

@end

NS_ASSUME_NONNULL_END
