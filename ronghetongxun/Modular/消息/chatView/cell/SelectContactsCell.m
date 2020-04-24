//
//  SelectContactsCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/14.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "SelectContactsCell.h"
#import <Masonry.h>
@implementation SelectContactsCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imgView];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 20.f;
    }
    return _imgView;
}
@end
