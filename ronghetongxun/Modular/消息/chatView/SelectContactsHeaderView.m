//
//  SelectContactsHeaderView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/14.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "SelectContactsHeaderView.h"
#import "SelectContactsCell.h"
#import <Masonry.h>
#import "UIColor+YM.h"
@interface SelectContactsHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)NSArray *allDataArray;
@property (nonatomic, strong)UIImageView *searchImgView;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, assign)CGFloat collectionViewWidth;

@end

static const CGFloat spacing = 16;
static const CGFloat searchHeight = 50;
static const CGFloat lineViewHeight = 10;

@implementation SelectContactsHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setCollectionViewLayout];
    [self setSearchViewLayout];
    [self setLineViewLayout];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCollectionViewLayout];
        [self setSearchViewLayout];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setData:(NSArray *)data{
    self.allDataArray = data;
    
    if (self.allDataArray.count>0) {
        
        [self setCollectionViewWidthWithCount:self.allDataArray.count];
    }else{
        [self setCollectionViewWidthWithCount:0];
    }
}

- (void)setCollectionViewWidthWithCount:(NSInteger)count{
    
    CGFloat maximumWidth = kScreenWidth() - 80;
    CGFloat minimum = 50;
    CGFloat width = maximumWidth;
    
    
    width = count == 0 ? spacing : minimum * count;
    if (width > maximumWidth) {
        width = maximumWidth;
    }
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
    }];
    
    if (count >0) {
        self.searchImgView.hidden = YES;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.collectionView.mas_trailing).inset(spacing);
        }];
    }else{
        self.searchImgView.hidden = NO;
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.mas_trailing);
            make.height.mas_equalTo(searchHeight);
            make.leading.mas_equalTo(self.searchImgView.mas_trailing).inset(10);
        }];
    }
    
    [self.collectionView reloadData];
}

///选择的人员列表滚动展示
- (void)setCollectionViewLayout{
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(spacing);
        make.leading.mas_equalTo(self.mas_leading);
        make.height.mas_equalTo(searchHeight);
        make.top.mas_equalTo(self.mas_top);
    }];
}

///搜索框与图标
- (void)setSearchViewLayout{
    [self addSubview:self.textField];
    [self addSubview:self.searchImgView];
    
    CGFloat searchImgViewWidth = 25;
    
    [self.searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(searchImgViewWidth);
        make.leading.mas_equalTo(self.collectionView.mas_trailing);
        make.centerY.mas_equalTo(self.textField.mas_centerY);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mas_trailing).inset(spacing);
        make.height.mas_equalTo(searchHeight);
        make.leading.mas_equalTo(self.searchImgView.mas_trailing).inset(10);
    }];
}
///底部线条
- (void)setLineViewLayout{
    [self addSubview:self.lineView];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(lineViewHeight);
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    SelectContactsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectContactsCell_id" forIndexPath:indexPath];
    cell.imgView.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allDataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(40, 40);
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[SelectContactsCell class] forCellWithReuseIdentifier:@"SelectContactsCell_id"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"搜索";
    }
    return _textField;
}
- (UIImageView *)searchImgView{
    if (!_searchImgView) {
        _searchImgView = [[UIImageView alloc] init];
        _searchImgView.image = [UIImage imageNamed:@"icon_msg_search"];
    }
    return _searchImgView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor ym_colorFromHexString:@"EDEDED"];
    }
    return _lineView;
}
- (NSArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSArray array];
    }
    return _allDataArray;
}



@end
