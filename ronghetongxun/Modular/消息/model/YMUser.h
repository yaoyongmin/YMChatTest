//
//  YMUser.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMUser : BaseModel
// 用户ID
@property (nonatomic, copy) NSString *eId;

// 用户名
@property (nonatomic, copy) NSString *eName;

// 新增 用户的头像photoid
@property (nonatomic, copy) NSString *photoId;

// 昵称
@property (nonatomic, copy) NSString *nName;

// 头像URL
@property (nonatomic, copy) NSString *headURL;

// 性别
@property (nonatomic, copy) NSString *sex;

// 手机号
@property (nonatomic, copy) NSString *phone;

// 办公手机号
@property (nonatomic, copy) NSString *mobile;

// 邮箱
@property (nonatomic, copy) NSString *email;

// 职务
@property (nonatomic, copy) NSString *jobTitle;

// 组织ID
@property (nonatomic, copy) NSString *oId;

// 部门名称
@property (nonatomic, copy) NSString *oName;

// 账号
@property (nonatomic, copy) NSString *account;


@end

NS_ASSUME_NONNULL_END
