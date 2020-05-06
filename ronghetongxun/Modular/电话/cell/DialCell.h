//
//  DialCell.h
//  ronghetongxun
//
//  Created by yym on 2020/4/30.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DialCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *centerLab;

@end

NS_ASSUME_NONNULL_END
