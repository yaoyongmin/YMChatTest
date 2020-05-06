//
//  YMRequestUrl.h
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#ifndef YMRequestUrl_h
#define YMRequestUrl_h

///HTTPS url
#define BaseUrl @""

///path
#define kLogin @"api/login"

#define kResetPass @"/api/account/resetPass"

///获取用户个人信息
#define kGetUserInfo @"/api/personalInfo/getUserInfo"

/** 获取通讯录列表
 * @param deptId 部门id  可选
 * @param pageNum 当前页数
 * @param pageSize 条数
 * @param searchTitle 搜索关键字
 */
#define kGetMembersList @"/api/membersList/getMembersList"

/** 获取个人通讯录列表
 * @param memberName 联系人姓名？ 为什么要根据姓名获取个人通讯录？？？
 * @param pageNum当前页数
 * @param pageSize条数
 */
#define kGetUserMemeberList @"/api/personMember/loadPersonMemberList"

/** 加载个人通讯录黑名单列表
 * @param memberName 用户名 非必传
 * @param pageNum
 * @param pageSize
 */
#define kGetBackList @"loadLockPersonMemberListUsingPOST"

/** 根据用户id获取通讯录联系人详细信息
 *  @param userId 用户id
 */
#define kGetUserInfoUsing @"/api/membersList/getUserInfo"

/** 个人通讯录新增联系人
 * @param memberId 联系人id
 */
#define kAddPersonMember @"/api/personMember/addPersonMember"

///获取组织架构
#define kGetDeptList @"api/membersList/getDeptList"

///获取聊天列表
#define kGetChatList @"/api/chatList/getChatList"

#endif /* YMRequestUrl_h */
