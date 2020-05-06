//
//  LaunchMeetingViewController.h
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "MeetingThemeView.h"
#import "LaunchMeetingModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LaunchMeetingViewController : BaseViewController





@end

///tableviewHeaderInsectionView
@interface HeaderInSectionView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

///tableviewCell
@interface LaunchMeetingCell : UITableViewCell

@property (nonatomic, strong) MeetingThemeView *meetingThemeView;

@property (nonatomic, strong) LaunchMeetingModel *model;

@end

NS_ASSUME_NONNULL_END
