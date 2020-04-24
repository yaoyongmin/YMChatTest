//
//  YMRequest.m
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "YMRequest.h"
@implementation YMRequest

+ (instancetype)sharedManager {
    static YMRequest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] init];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        //http请求格式
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 30;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        //        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        ///json解析格式
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    }
    return self;
}


- (void)getRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler
{
    [self GET:[NSString stringWithFormat:@"%@/%@",BaseUrl,url] parameters:params progress: nil
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        
        if ([self requestSuccesErrorCode:code]) {
            successHandler(code,message,data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        [self requestErrorCode:error.code];
        failureHandler(error);
    }];
    
}

- (void)postRequest:(NSString *)url
             params:(NSDictionary *)params
            success:(requestSuccessBlock)successHandler
            failure:(requestFailureBlock)failureHandler
{
    [self POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:params progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
        NSArray *allKeys = [responseObject allKeys];
        
        NSInteger code = [allKeys containsObject:@"data"] ? [[responseObject objectForKey:@"code"] integerValue] : 999;
        NSString *message = [allKeys containsObject:@"data"] ? [responseObject objectForKey:@"msg"] : @"";
        id data = [allKeys containsObject:@"data"] ? [responseObject objectForKey:@"data"] : @{};
        
        if ([self requestSuccesErrorCode:code]) {
            successHandler(code,message,data);
        }else{
            NSLog(@"服务器错误：%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        
        [self requestErrorCode:error.code];
        failureHandler(error);
    }];
}
- (void)putRequest:(NSString *)url
            params:(NSDictionary *)params
           success:(requestSuccessBlock)successHandler
           failure:(requestFailureBlock)failureHandler
{
    [self PUT:url parameters:params
      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        if ([self requestSuccesErrorCode:code]) {
            successHandler(code,message,data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        failureHandler(error);
        [self requestErrorCode:error.code];
    }];
}

- (void)deleteRequest:(NSString *)url
               params:(NSDictionary *)params
              success:(requestSuccessBlock)successHandler
              failure:(requestFailureBlock)failureHandler
{
    [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        if ([self requestSuccesErrorCode:code]) {
            successHandler(code,message,data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------请求失败-------%@",error);
        failureHandler(error);
        [self requestErrorCode:error.code];
    }];
}


/**
 下载文件，监听下载进度
 */
- (void)downloadRequest:(NSString *)url
     successAndProgress:(progressBlock)progressHandler
            destination:(destinationBlock _Nullable)destinationHandler
               complete:(responseBlock _Nullable)completionHandler
{
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block  NSProgress *kProgress = nil;
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        kProgress = downloadProgress;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentUrl = [[NSFileManager defaultManager] URLForDirectory :NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        documentUrl = [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
        destinationHandler(documentUrl);
        return documentUrl;
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nonnull filePath, NSError * _Nonnull error){
        if (error) {
            NSLog(@"------下载失败-------%@",error);
        }
        completionHandler(response, error);
        [self requestErrorCode:error.code];
    }];
    
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        
        progressHandler(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        
    }];
    [downloadTask resume];
}

/**
 *
 *   上传文件，监听上传进度
 */
- (void)updateRequest:(NSString *)url
               params:(NSDictionary *)params
           fileConfig:(NSArray<YMFileParam*> *)fileArray
             progress:(progressBlock)progressHandler
              success:(requestSuccessBlock)successHandler
             complete:(responseBlock)completionHandler
{
    
    //上传图片延长 上传时间
    self.requestSerializer.timeoutInterval = 40;
    
    [self POST:[NSString stringWithFormat:@"%@/%@",BaseUrl,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        if (params.count>0 && params != NULL) {
            for (YMFileParam *upload in fileArray) {
                
                [formData appendPartWithFileData:upload.fileData name:upload.name fileName:upload.fileName mimeType:upload.mimeType];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress){
        progressHandler(0,0,0);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        NSString *message = [responseObject objectForKey:@"msg"];
        id data = [responseObject objectForKey:@"data"];
        if ([self requestSuccesErrorCode:code]) {
            successHandler(code,message,data);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestErrorCode:error.code];
        completionHandler(task,error);
    }];
}


/// 网络请求错误
/// @param errorCode 错误代码
- (void)requestErrorCode:(NSUInteger )errorCode{
    
    switch (errorCode) {
        case -1001:
            [MBProgressHUD showError:@"网络请求超时！" integer:errorCode];
            break;
        case -1004:
            
            [MBProgressHUD showError:@"无法连接服务器！" integer:errorCode];
            break;
        case -1009:
            
            [MBProgressHUD showError:@"无网络连接，请检查网络！" integer:errorCode];
            break;
        default:
            
            [MBProgressHUD showError:@"请求失败！" integer:errorCode];
            break;
    }
}

- (BOOL)requestSuccesErrorCode:(NSInteger )errorCode{
    switch (errorCode) {
        case 0:
            return YES;
            break;
        case 200:
            return YES;
            break;
        case 201:
            [MBProgressHUD showError:@"服务器错误！" integer:errorCode];
            return NO;
            break;
        case 401:
            [MBProgressHUD showError:@"服务器验证失败！" integer:errorCode];
            return NO;
            break;
        case 403:
            [MBProgressHUD showError:@"服务器拒绝访问！" integer:errorCode];
            return NO;
            break;
        case 404:
            [MBProgressHUD showError:@"服务器请求失败！" integer:errorCode];
            return NO;
            break;
        default:
            [MBProgressHUD showError:@"请求失败！" integer:errorCode];
            return NO;
            break;
    }
}
@end
