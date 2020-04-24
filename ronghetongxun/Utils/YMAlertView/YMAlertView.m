//
//  YMAlertView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMAlertView.h"
#import "YMAlertViewCell.h"
#import <Masonry.h>
#import "UIColor+YM.h"
@interface YMAlertView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *mainView;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UIButton *cancelBtn;

@end

static const CGFloat itemHeight = 55;

@implementation YMAlertView

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                dataList:(NSArray <YMAlertModel *>*)list
{
    YMAlertView *view = [[YMAlertView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.alertTitle = title;
    view.dataList = list;
    view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5f];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.titleLab];
        [self.mainView addSubview:self.lineView];
        [self.mainView addSubview:self.tableView];
        [self.mainView addSubview:self.cancelBtn];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    
    [self dismiss];
}

-(void)show{
    [self show:[UIApplication sharedApplication].keyWindow];
}

-(void)show:(UIView *)superView{
    [superView addSubview:self];
    
    [self setlayoutSubviews];
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        [self layoutIfNeeded];
    }];
    
    self.titleLab.text = self.alertTitle;
    if (self.dataList.count <=4) {
        self.tableView.scrollEnabled = NO;
    }
}

- (void)dismiss{
    CGFloat mainViewHeight = self.dataList.count > 4 ? itemHeight * 6 : itemHeight*(self.dataList.count + 2);

    [UIView animateWithDuration:.5f animations:^{
        [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(mainViewHeight);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickCancelAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(YMAlertViewClickCancelAction:)]) {
        [self.delegate YMAlertViewClickCancelAction:self];
    }else{
        [self dismiss];
    }
}

- (void)setlayoutSubviews{
    
    CGFloat mainViewHeight = self.dataList.count > 4 ? itemHeight * 6 : itemHeight*(self.dataList.count + 2);
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(mainViewHeight);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(mainViewHeight);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainView.mas_top);
        make.height.mas_equalTo(itemHeight-1);
        make.leading.trailing.mas_equalTo(self.mainView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.leading.trailing.mas_equalTo(15);
        make.top.mas_equalTo(self.titleLab.mas_bottom);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mainView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.mainView);
        make.height.mas_equalTo(itemHeight);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.mainView);
        make.bottom.mas_equalTo(self.cancelBtn.mas_top);
    }];
    [self layoutIfNeeded];
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor ym_colorFromHexString:@"#666666"];
        _titleLab.font = [UIFont systemFontOfSize:11.f];
    }
    return _titleLab;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor ym_colorFromHexString:@"#EFEFEF"];
    }
    return _lineView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellEditingStyleInsert;
        [_tableView registerClass:[YMAlertViewCell class] forCellReuseIdentifier:@"YMAlertViewCell_id"];
    }
    return _tableView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor ym_colorFromHexString:@"#333333"] forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_cancelBtn addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    YMAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YMAlertViewCell_id" forIndexPath:indexPath];
    [cell setData:self.dataList[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return itemHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YMAlertView:didSelectRowAtSEL:)]) {
        
        [self.delegate YMAlertView:self didSelectRowAtSEL:self.dataList[indexPath.row].action];
    }
}
@end
