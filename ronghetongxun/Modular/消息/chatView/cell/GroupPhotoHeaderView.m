//
//  GroupPhotoHeaderView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupPhotoHeaderView.h"
#import "UIColor+YM.h"
@implementation GroupPhotoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self addSubview:self.titleLab];
    }
    return self;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width-32, 44)];
        _titleLab.text      = @"测试11111";
        _titleLab.textColor = [UIColor ym_colorFromHexString:@"#666666"];
        _titleLab.font      = [UIFont systemFontOfSize:12.f];
    }
    return _titleLab;
}
@end
