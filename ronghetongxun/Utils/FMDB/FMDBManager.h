//
//  FMDBManager.h
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabaseQueue.h>
NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

+(FMDBManager *) sharedInstance;

-(void) inDatabase:(void(^)(FMDatabase*))block;

- (void)inTransaction:(void(^)(FMDatabase *db, BOOL rollback))block;


@end

NS_ASSUME_NONNULL_END
