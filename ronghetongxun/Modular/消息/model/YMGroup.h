//
//  YMGroup.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseModel.h"
#import "YMUser.h"
#import "ICChatServerDefs.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMGroup : BaseModel
// 组名称
@property (nonatomic, copy) NSString *gName;
// 组ID
@property (nonatomic, copy) NSString *gId;

///当前聊天状态 单人 多人等
@property (nonatomic, assign) ICGroupType gType;

// 当前用户是否是群主（0: 不是 1：是 ）如果是双人的话，没有master
@property (nonatomic, assign) int master;
// 组成员
@property (nonatomic, strong) NSMutableArray<YMUser *> *userList;
// 组的未读数
@property (nonatomic, assign) int unReadCount;
// 组状态
@property (nonatomic, assign) int valid;
// 当期用户设置该群的群属性 免打扰（0: 不是 1：是 ）
@property (nonatomic, assign) int busy;
// 是否置顶(1表示置顶，其它都是不置顶)
@property (nonatomic, assign) int isTop;
// 最好一条消息内容
@property (nonatomic, copy) NSString * lastMsgString;
// 最后一条消息时间
@property (nonatomic, assign) NSInteger lastMsgTime;

@property (nonatomic, copy) NSString *drafts;

//// 本地状态，0:不显示，1:显示
//@property (nonatomic, assign) int localType;

@property (nonatomic, assign) BOOL isDraft;

// 新版本添加的头像
@property (nonatomic, copy) NSString *photoId;

@end

NS_ASSUME_NONNULL_END
