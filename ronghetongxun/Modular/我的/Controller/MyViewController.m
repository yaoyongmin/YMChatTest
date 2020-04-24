//
//  MyViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MyViewController.h"

#import "YMAlertView.h"
@interface MyViewController ()<YMAlertViewDelegate>
{
    NSArray *_listArray;
}
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray <YMAlertModel *> *listArray = [NSMutableArray array];
    
    for (int i =0; i<4; i++) {
        
        YMAlertModel *model = [YMAlertModel new];
        [model setValuesForKeysWithDictionary:@{@"content":@"测试",@"imageName":@""}];
        if (i == 1) {
            [model setAction:@selector(testAction1)];
        }else{
            [model setAction:@selector(testAction)];
        }
        [listArray addObject:model];
    }
    
    _listArray = listArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    YMAlertView *alertView = [YMAlertView alertControllerWithTitle:@"标题" dataList:_listArray];
    alertView.delegate = self;
    
    [alertView show];
}

- (void)YMAlertView:(YMAlertView *)alertView didSelectRowAtSEL:(SEL)action{
    NSString *sel = NSStringFromSelector(action);

    YMPerformSelectorMacro(self,sel);
}

- (void)testAction{
    
    NSLog(@"点击事件!");
}

- (void)testAction1{
    
    NSLog(@"点击事件11111!");
}

@end
