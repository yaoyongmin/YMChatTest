//
//  YMAlertViewCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMAlertViewCell.h"
#import "UIColor+YM.h"
#import <UIView+MJExtension.h>
@implementation YMAlertViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.itemBtn];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews{
    [self.itemBtn setFrame:CGRectMake(15, 0, self.bounds.size.width-30, self.bounds.size.height-1)];
    [self.lineView setFrame:CGRectMake(15, self.bounds.size.height-1, self.bounds.size.width-30, 1)];
}


- (void)setData:(YMAlertModel *)model{
    
    self.itemBtn.contentHorizontalAlignment = model.contentHorizontalAlignment;
    
    [self.itemBtn setTitle:model.content
                  forState:UIControlStateNormal];
    
    if (model.itemTitleColor) {
        [self.itemBtn setTitleColor:model.itemTitleColor forState:UIControlStateNormal];
    }
    
    if (model.imageName && model.imageName.length > 0) {
        [self.itemBtn setImage:[UIImage imageNamed:model.imageName]
                      forState:UIControlStateNormal];
        self.itemBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    }
}
- (UIButton *)itemBtn{
    if (!_itemBtn) {
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemBtn.userInteractionEnabled = NO;
        [_itemBtn setTitleColor:[UIColor ym_colorFromHexString:@"#333333"]
                       forState:UIControlStateNormal];
        [_itemBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    }
    return _itemBtn;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor ym_colorFromHexString:@"#EFEFEF"];
    }
    return _lineView;
}
@end
