//
//  BaseTableVIewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/28.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseTableVIewController.h"

@interface BaseTableVIewController ()

@end

@implementation BaseTableVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)addRefreshParts{
    [self addRefreshFooter:NO];
    [self addRefreshHeader:NO];
}
#pragma mark private method
-(void)addRefreshFooter:(BOOL)beginRefresh{
    //上拉更多
    self.baseTableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    if (beginRefresh) {
        [self.baseTableView.mj_footer beginRefreshing];
    }
}
-(void)addRefreshHeader:(BOOL)beginRefresh{
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    if (beginRefresh) {
        [self.baseTableView.mj_header beginRefreshing];
    }
}

#pragma mark 下拉刷新数据
- (void)loadNewData{
    _currentPage=1;
    [self getDataList];
    [self.baseTableView.mj_header endRefreshing];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData{
    _currentPage+=1;
    [self getDataList];
    [self.baseTableView.mj_footer endRefreshing];
}

#pragma mark get请求数据时调用
- (void)getDataList{

    
}

-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

@end
