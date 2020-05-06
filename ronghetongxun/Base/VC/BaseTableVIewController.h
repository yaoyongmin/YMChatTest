//
//  BaseTableVIewController.h
//  ronghetongxun
//
//  Created by yym on 2020/4/28.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVIewController : BaseViewController

@property(nonatomic,strong)NSMutableArray *dataArray;       //数据源
@property(nonatomic,assign)NSInteger    currentPage;        //加载数据分页计数

@property (nonatomic, strong) UITableView *baseTableView;

/**
 * 添加上下拉刷新部件
 */
- (void)addRefreshParts;
/**
 * 添加上拉下拉刷新
 */
-(void)addRefreshFooter:(BOOL)beginRefresh;
-(void)addRefreshHeader:(BOOL)beginRefresh;
/**
 * 上拉刷新
 */
- (void)loadNewData;
/**
 * 下拉加载更多
 */
- (void)loadMoreData;

/**
 * 加载数据
 */
- (void)getDataList;

@end

NS_ASSUME_NONNULL_END
