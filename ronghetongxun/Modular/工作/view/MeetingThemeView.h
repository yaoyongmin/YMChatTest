//
//  MeetingThemeView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ selectStartTimeBlock) (NSString *dateString);
typedef void (^ selectEndTimeBlock) (NSString *dateString);
typedef void (^ startInputBlock) (NSString *text);


@interface MeetingThemeView : UIView

@property (nonatomic, strong)UITextField *themeTextField;
@property (nonatomic, strong)UIButton *startTimeBtn;
@property (nonatomic, strong)UIButton *endTimeBtn;

@property (nonatomic, copy)selectStartTimeBlock startTimeBlock;
@property (nonatomic, copy)selectEndTimeBlock endTimeBlock;
@property (nonatomic, copy)startInputBlock startInputBlock;

@end

NS_ASSUME_NONNULL_END
