//
//  MeetingThemeView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MeetingThemeView.h"
#import "UIColor+YM.h"
#import <Masonry.h>
#import "CXDatePickerView.h"
@interface MeetingThemeView()<UITextFieldDelegate>

@property (nonatomic, strong)UILabel *themeLab;
@property (nonatomic, strong)UILabel *startTimeLab;
@property (nonatomic, strong)UILabel *endTimeLab;

@property (nonatomic, strong)UIView *lineView1;
@property (nonatomic, strong)UIView *lineView2;

@property (nonatomic, strong)UIImageView *startCalendarImgView;
@property (nonatomic, strong)UIImageView *endCalendarImgView;

@end

@implementation MeetingThemeView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.themeLab];
    [self addSubview:self.themeTextField];
    [self addSubview:self.lineView1];
    [self addSubview:self.startTimeLab];
    [self addSubview:self.startTimeBtn];
    [self addSubview:self.lineView2];
    [self addSubview:self.endTimeLab];
    [self addSubview:self.endTimeBtn];
    [self addSubview:self.startCalendarImgView];
    [self addSubview:self.endCalendarImgView];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.themeLab];
        [self addSubview:self.themeTextField];
        [self addSubview:self.lineView1];
        [self addSubview:self.startTimeLab];
        [self addSubview:self.startTimeBtn];
        [self addSubview:self.lineView2];
        [self addSubview:self.endTimeLab];
        [self addSubview:self.endTimeBtn];
        [self addSubview:self.startCalendarImgView];
        [self addSubview:self.endCalendarImgView];
    }
    return self;
}

- (void)selectStartTimeAction:(UIButton *)sender{
    //年-月-日-时-分
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"开始日期：%@",dateString);
        if (self.startTimeBlock) {
            self.startTimeBlock(dateString);
        }else{
            [self.startTimeBtn setTitle:dateString forState:UIControlStateNormal];
        }
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.headerViewColor = [UIColor orangeColor]; // 顶部视图背景颜色
    datepicker.doneButtonColor = [UIColor whiteColor]; // 确认按钮字体颜色
    datepicker.cancelButtonColor = [UIColor whiteColor]; // 取消按钮颜色
    datepicker.shadeViewAlphaWhenShow = 0.3;
    datepicker.showAnimationTime = 0.4;
    datepicker.minLimitDate = [NSDate date];
    datepicker.hideBackgroundYearLabel = NO;
    [datepicker show];
}
- (void)selectEndTimeAction:(UIButton *)sender{
    //年-月-日-时-分
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"结束日期：%@",dateString);
        if (self.endTimeBlock) {
            self.endTimeBlock(dateString);
        }else{
            [self.endTimeBtn setTitle:dateString forState:UIControlStateNormal];
        }
    }];
    datepicker.dateLabelColor = [UIColor orangeColor];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.headerViewColor = [UIColor orangeColor]; // 顶部视图背景颜色
    datepicker.doneButtonColor = [UIColor whiteColor]; // 确认按钮字体颜色
    datepicker.cancelButtonColor = [UIColor whiteColor]; // 取消按钮颜色
    datepicker.shadeViewAlphaWhenShow = 0.3;
    datepicker.showAnimationTime = 0.4;
    datepicker.minLimitDate = [NSDate date];
    datepicker.hideBackgroundYearLabel = NO;
    [datepicker show];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.startInputBlock) {
        self.startInputBlock(textField.text);
    }
}

- (void)layoutSubviews{
    
    [self.themeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.leading.mas_equalTo(self.mas_leading);
        make.height.mas_equalTo(@44);
    }];
    [self.themeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.leading.mas_equalTo(self.themeLab.mas_trailing).inset(5);
        make.height.mas_equalTo(@45);
    }];
    [self.lineView1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.themeLab.mas_bottom);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    [self.startTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.themeLab.mas_bottom);
        make.leading.mas_equalTo(self.mas_leading);
        make.height.mas_equalTo(@44);
    }];
    [self.startCalendarImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.startTimeLab.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.width.height.mas_equalTo(@13);
    }];
    [self.startTimeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.startTimeLab.mas_centerY);
        make.trailing.mas_equalTo(self.startCalendarImgView.mas_leading).inset(3);
        make.height.mas_equalTo(@45);
    }];
    [self.lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTimeLab.mas_bottom);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    [self.endTimeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTimeLab.mas_bottom);
        make.leading.mas_equalTo(self.mas_leading);
        make.height.mas_equalTo(@45);
    }];
    [self.endCalendarImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.endTimeLab.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing);
        make.width.height.mas_equalTo(@13);
    }];
    [self.endTimeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.endTimeLab.mas_centerY);
        make.trailing.mas_equalTo(self.startCalendarImgView.mas_leading).inset(3);
        make.height.mas_equalTo(@45);
    }];
}
- (UILabel *)themeLab{
    if (!_themeLab) {
        _themeLab           = [[UILabel alloc] init];
        _themeLab.text      = @"会议主题";
        _themeLab.font      = [UIFont systemFontOfSize:14.f];
        _themeLab.textColor = [UIColor ym_colorFromHexString:@"#323232"];
    }
    return _themeLab;
}
- (UILabel *)startTimeLab{
    if (!_startTimeLab) {
        _startTimeLab           = [[UILabel alloc] init];
        _startTimeLab.text      = @"开始时间";
        _startTimeLab.font      = [UIFont systemFontOfSize:14.f];
        _startTimeLab.textColor = [UIColor ym_colorFromHexString:@"#323232"];
    }
    return _startTimeLab;
}
- (UILabel *)endTimeLab{
    if (!_endTimeLab) {
        _endTimeLab           = [[UILabel alloc] init];
        _endTimeLab.text      = @"结束时间";
        _endTimeLab.font      = [UIFont systemFontOfSize:14.f];
        _endTimeLab.textColor = [UIColor ym_colorFromHexString:@"#323232"];
    }
    return _endTimeLab;
}
- (UITextField *)themeTextField{
    if (!_themeTextField) {
        _themeTextField                 = [[UITextField alloc] init];
        _themeTextField.placeholder     = @"请输入标题";
        _themeTextField.font            = [UIFont systemFontOfSize:14.f];
        _themeTextField.textColor       = [UIColor ym_colorFromHexString:@"#666666"];
        _themeTextField.delegate        = self;
        _themeTextField.textAlignment   = NSTextAlignmentRight;
    }
    return _themeTextField;
}
- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor ym_colorFromHexString:@"F7F8F9"];
    }
    return _lineView1;
}
- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor ym_colorFromHexString:@"F7F8F9"];
    }
    return _lineView2;
}
- (UIButton *)startTimeBtn{
    if (!_startTimeBtn) {
        _startTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startTimeBtn setTitle:@"1970-00-00" forState:UIControlStateNormal];
        [_startTimeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_startTimeBtn setTitleColor:[UIColor ym_colorFromHexString:@"#909090"] forState:UIControlStateNormal];
        _startTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_startTimeBtn addTarget:self action:@selector(selectStartTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startTimeBtn;
}
- (UIButton *)endTimeBtn{
    if (!_endTimeBtn) {
        _endTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endTimeBtn setTitle:@"1970-00-00" forState:UIControlStateNormal];
        [_endTimeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_endTimeBtn setTitleColor:[UIColor ym_colorFromHexString:@"#909090"] forState:UIControlStateNormal];
        [_endTimeBtn addTarget:self action:@selector(selectEndTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        _endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _endTimeBtn;
}
- (UIImageView *)startCalendarImgView{
    if (!_startCalendarImgView) {
        _startCalendarImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_calendar"]];
    }
    return _startCalendarImgView;
}
- (UIImageView *)endCalendarImgView{
    if (!_endCalendarImgView) {
        _endCalendarImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_calendar"]];
    }
    return _endCalendarImgView;
}
@end
