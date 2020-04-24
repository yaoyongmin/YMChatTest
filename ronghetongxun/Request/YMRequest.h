//
//  YMRequest.h
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMFileParam.h"
#import <AFNetworking.h>
#import "YMRequestUrl.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMRequest : AFHTTPSessionManager

/**
 请求成功block
 */
typedef void (^requestSuccessBlock)(NSInteger code, NSString * _Nullable message, _Nullable id data);

/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError * _Nullable error);

/**
 请求响应block
 */
typedef void (^responseBlock)(_Nullable id dataObj, NSError * _Nullable error);

/**
 监听进度响应block
 */
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);
/**
 下载文件的路径响应block
 */
typedef void (^destinationBlock)(NSURL * _Nonnull documentUrl);


+ (instancetype)sharedManager;

/**
 GET请求
 */
- (void)getRequest:(nonnull NSString *)url
            params:(NSDictionary * _Nullable)params
           success:(_Nullable requestSuccessBlock)successHandler
           failure:(_Nullable requestFailureBlock)failureHandler;

/**
 POST请求
 */
- (void)postRequest:(nonnull NSString *)url
             params:(NSDictionary *_Nullable )params
            success:(_Nullable requestSuccessBlock)successHandler
            failure:(_Nullable requestFailureBlock)failureHandler;

/**
 PUT请求
 */
- (void)putRequest:(nonnull NSString *)url
            params:(NSDictionary *_Nullable )params
           success:(_Nullable  requestSuccessBlock)successHandler
           failure:(_Nullable  requestFailureBlock)failureHandler;

/**
 DELETE请求
 */
- (void)deleteRequest:(nonnull NSString *)url
               params:(NSDictionary *_Nullable )params
              success:(_Nullable requestSuccessBlock)successHandler
              failure:(_Nullable requestFailureBlock)failureHandler;

/**
 下载文件，监听下载进度
 */
- (void)downloadRequest:(nonnull NSString *)url
     successAndProgress:(_Nullable progressBlock)progressHandler
            destination:(_Nullable destinationBlock)destinationHandler
               complete:(_Nullable responseBlock)completionHandler;

/**
 文件上传，监听上传进度
 */
- (void)updateRequest:(NSString * _Nullable )url
               params:( NSDictionary * _Nullable )params
           fileConfig:( NSArray<YMFileParam*> * _Nullable )fileArray
             progress:(_Nullable progressBlock)progressHandler
              success:(_Nullable requestSuccessBlock)successHandler
             complete:(_Nullable responseBlock)completionHandler;
@end

NS_ASSUME_NONNULL_END
