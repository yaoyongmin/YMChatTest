//
//  FMDBManager.m
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager{
    
    FMDatabaseQueue *queue;
}

-(id)init{
    self = [super init];
    if(self){
        NSString *dbFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ronghetongxun_db.sqlite"];
        NSLog(@"%@", dbFilePath);
        queue = [FMDatabaseQueue databaseQueueWithPath:dbFilePath];
    }
    return self;
}

+(FMDBManager *) sharedInstance{
    //多线程保护
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void) inDatabase:(void(^)(FMDatabase*))block{
    [queue inDatabase:^(FMDatabase *db){
        block(db);
    }];
}

- (void)inTransaction:(void(^)(FMDatabase *db, BOOL rollback))block{
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        block(db, rollback);
    }];
}

@end
