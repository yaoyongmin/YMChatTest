//
//  MessageMoreView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MessageMoreView.h"
#import <Masonry.h>
#import <UIView+MJExtension.h>
#import "UIColor+YM.h"
#import "CAShapeLayer+ViewMask.h"
#import "Define.h"
@interface MessageMoreView()
{
    BOOL _isShow;
    
    NSArray *_dataArray;
}

@end
@implementation MessageMoreView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
        
        _isShow = NO;
        _dataArray = [NSArray arrayWithObjects:@"发起群聊",@"添加联系人",@"扫一扫", nil];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:ges];
        
        [self addSubview:self.moreView];
        
        for (int i = 0; i<_dataArray.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(10,  i * (115 /3) + 10, self.moreView.mj_w, 115/3)];
            [btn setTitleColor:[UIColor ym_colorFromHexString:@"#333333"] forState:UIControlStateNormal];
            [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"icon_tabbar_work2"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(didClickMoreAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            btn.tag = 1000+i;
            [self.moreView addSubview:btn];
        }
    }
    return self;
}

- (void)didClickMoreAction:(UIButton *)sender{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageMoreView:didSelectRowAtIndex:)]) {
        [self.delegate messageMoreView:self didSelectRowAtIndex:sender.tag - 1000];
    }
}

- (void)show:(UIView *)superView{
    if (_isShow) {
        return;
    }
    if (superView) {
        _isShow = YES;
        [superView addSubview:self];
    }
}

- (BOOL)isShowState{
    return _isShow;
}

- (void)dismiss{
    _isShow = NO;
    [self removeFromSuperview];
}

- (UIView *)moreView{
    if (!_moreView) {
        _moreView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth()-110-10, 0, 110, 125)];
        _moreView.backgroundColor = [UIColor whiteColor];
        CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:_moreView];
        _moreView.layer.mask = layer;
        _moreView.layer.masksToBounds = YES;
        _moreView.layer.cornerRadius = 3.f;
    }
    return _moreView;
}
@end
