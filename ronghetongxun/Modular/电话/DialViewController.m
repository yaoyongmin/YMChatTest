//
//  DialViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/30.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "DialViewController.h"
#import "DialCell.h"
@interface DialViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_keyArray;
    NSArray *_keyLetterArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@end

@implementation DialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拨号";
    
    _keyArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*",@"0",@"#"];
    _keyLetterArray = @[@"",@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"PQRS",@"TUV",@"WXYZ",@"",@"+",@""];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DialCell class]) bundle:nil] forCellWithReuseIdentifier:@"DialCell_id"];
}
- (IBAction)deletePhoneAction:(id)sender {
    if (self.phoneLab.text.length >= 1) {
        NSString *phone     = [self.phoneLab.text substringToIndex:self.phoneLab.text.length - 1];
        self.phoneLab.text  = phone;
    }
}
- (IBAction)dialAction:(id)sender {
    if (self.phoneLab.text.length >= 1) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneLab.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DialCell_id" forIndexPath:indexPath];
    
    if (indexPath.item == 9 || indexPath.item == 11) {
        cell.centerLab.text = _keyArray[indexPath.item];
    }else{
        cell.contentLab.text  = _keyArray[indexPath.item];
        cell.subTitleLab.text = _keyLetterArray[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.phoneLab.text = [NSString stringWithFormat:@"%@%@",self.phoneLab.text,_keyArray[indexPath.item]];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _keyArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (kScreenWidth() * 0.786 - 40) /3;
    return CGSizeMake(w, w);
}

@end
