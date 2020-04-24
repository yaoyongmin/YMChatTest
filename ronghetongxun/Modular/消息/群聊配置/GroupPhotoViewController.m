//
//  GroupPhotoViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupPhotoViewController.h"
#import "GroupPhotoHeaderView.h"
#import "GroupPhotoCell.h"
@interface GroupPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation GroupPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    
    [self.view addSubview:self.collectionView];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GroupPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupPhotoCell_id" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GroupPhotoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupPhotoHeaderView_id" forIndexPath:indexPath];
        
        return headerView;
    }
    return NULL;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (kScreenWidth()-50)/4;
    return CGSizeMake(w, w);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth(), 44);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), kScreenHeight()-kHomeIndicatorHeight()) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource      = self;
        _collectionView.delegate        = self;
        _collectionView.showsHorizontalScrollIndicator  = NO;
        _collectionView.showsVerticalScrollIndicator    = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GroupPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:@"GroupPhotoCell_id"];
        [_collectionView registerClass:[GroupPhotoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupPhotoHeaderView_id"];
    }
    return _collectionView;
}
@end
