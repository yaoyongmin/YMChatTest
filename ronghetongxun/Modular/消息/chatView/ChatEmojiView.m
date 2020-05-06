//
//  ChatEmojiView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/16.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatEmojiView.h"
#import "ChatEmojiCell.h"
#import "EaseEmoji.h"
#import <UIView+MJExtension.h>
@implementation ChatEmojiView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.allEmoji = [EaseEmoji allEmoji];
        [self addSubview:self.emojiCollectionView];
        [self addSubview:self.sendBtn];
    }
    return self;
}

- (void)layoutSubviews{
    
    
}

- (void)clickSendAction{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChatEmojiViewClickSendButtonAction)]) {
        [self.delegate ChatEmojiViewClickSendButtonAction];
    }
}

- (UICollectionView *)emojiCollectionView{
    if (!_emojiCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _emojiCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
        _emojiCollectionView.delegate = self;
        _emojiCollectionView.dataSource = self;
        _emojiCollectionView.backgroundColor = [UIColor whiteColor];
        [_emojiCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ChatEmojiCell class]) bundle:nil] forCellWithReuseIdentifier:@"ChatEmojiCell_id"];
    }
    return _emojiCollectionView;
}

- (UIButton *)sendBtn{
    if (!_sendBtn){
        
        CGFloat w   = 80;
        CGFloat h   = 35;
        _sendBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn setFrame:CGRectMake(self.mj_w-w-10, self.mj_h-h-kHomeIndicatorHeight(), w, h)];
        _sendBtn.layer.masksToBounds    = YES;
        _sendBtn.layer.cornerRadius     = 5;
        [_sendBtn addTarget:self action:@selector(clickSendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatEmojiCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"ChatEmojiCell_id" forIndexPath:indexPath];
    
    cell.emojiLabel.text = self.allEmoji[indexPath.item];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allEmoji.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChatEmojiView:didSelectEmojiItemAtText:)]) {
        [self.delegate ChatEmojiView:self didSelectEmojiItemAtText:self.allEmoji[indexPath.item]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat w = kScreenWidth() - 70 - 20;
    
    return CGSizeMake(w/8, w/8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
