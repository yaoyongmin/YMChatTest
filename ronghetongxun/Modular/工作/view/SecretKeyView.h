//
//  SecretKeyView.h
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecretKeyView : UIView
@property (weak, nonatomic) IBOutlet UILabel *secretKeyLab;

- (void)show:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
