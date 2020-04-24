//
//  DBRecorder.m
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "DBRecorder.h"
#import "FMDBManager.h"
#import <FMDB.h>
@implementation DBRecorder

+ (void)insertChatData:(ChatDataModel *)charData{
    
    FMDBManager *helper = [FMDBManager sharedInstance];
    
    [helper inTransaction:^(FMDatabase * _Nonnull db, BOOL rollback) {
        
        @try {
            if ([db open]) {
                [db setShouldCacheStatements:YES];
                
                if (![db tableExists:@"chatList"]) {
                    [db executeUpdate:@"CREATE TABLE chatList(id INTEGER PRIMARY KEY, chatID INTEGER, content TEXT, photoURL TEXT, VideoURL TEXT, chatRowID INTEGER)"];
                    NSLog(@"聊天记录表创建完成！");
                }
                
                ChatDataModel *model = charData;
                FMResultSet *chatRs = [db executeQuery:@"select * from chatList where chatRowID = ?", model.chatRowID];
                
                if ([chatRs next]) {
                    
                    BOOL isUpdate = [db executeUpdate:@"update chatList set content = ?, photoURL = ?, VideoURL = ?, chatID = ? where chatRowID = ?", model.content, model.photoURL, model.videoURL, model.chatID,model.chatRowID];
                    
                    if (isUpdate) {
                        NSLog(@"更新成功");
                    }
                }else{
                    [db executeUpdate:@"insert into chatList(chatID, content, photoURL, VideoURL, chatRowID) values(?,?,?,?,?)", model.chatID, model.content, model.photoURL, model.videoURL,model.chatRowID];
                    NSLog(@"插入成功");
                }
                [chatRs close];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }];
}

+ (void)deleChatDataWith:(nonnull id)charID{
    
    FMDBManager *helper = [FMDBManager sharedInstance];
    
    [helper inTransaction:^(FMDatabase * _Nonnull db, BOOL rollback) {
        if ([db open]) {
           BOOL isDelete = [db executeUpdate: [NSString stringWithFormat:@"delete from chatList where chatID = %@",charID]];
            if (isDelete) {
                NSLog(@"删除成功！");
            }else{
                NSLog(@"删除失败！");
            }
        }
    }];
}

+ (NSArray <ChatDataModel *>*)getChatData:(id)chatID{
    
    FMDBManager *helper = [FMDBManager sharedInstance];
    NSMutableArray *chatDataArray = [NSMutableArray array];
    [helper inTransaction:^(FMDatabase *db, BOOL rollback) {
        
        if ([db open]) {
            FMResultSet *chatRs = [db executeQuery:@"select * from chatList where chatID = ?", chatID];
            while ([chatRs next]) {
                
                ChatDataModel *model = [[ChatDataModel alloc] init];
                model.chatID = [NSNumber numberWithInt:[chatRs intForColumn:@"charID"]];
                model.content = [chatRs stringForColumn:@"content"];
                model.photoURL = [chatRs stringForColumn:@"photoURL"];
                model.videoURL = [chatRs stringForColumn:@"videoURL"];
                [chatDataArray addObject:model];
            }
            [chatRs close];
        }else{
            NSLog(@"聊天记录数据库打开失败！");
        }
    }];
    return chatDataArray;
}

- (void)text{
    
    
}
@end
