//
//  APIManager.m
//  AFNetworking-demo
//
//  Created by Jakey on 16/4/1.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "APIManager.h"


static dispatch_once_t onceToken;
static APIManager *_sharedManager = nil;

@implementation APIManager
+ (instancetype _Nullable)sharedManager {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        NSString *baseUri = [ExpressViewModel getBaseUri];
        _sharedManager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:[baseUri stringByAppendingString:URI_ROOT]]];
        [_sharedManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        
        [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    DLog(@"3G网络已连接");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    DLog(@"WiFi网络已连接");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    DLog(@"网络连接失败");
                    break;
                    
                default:
                    break;
            }
        }];
        [_sharedManager.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        
        //发送json数据
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        //响应json数据
        _sharedManager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
        _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml", @"application/x-www-form-urlencoded;charset=utf-8",nil]];
    });
    
    return _sharedManager;
}

+ (nullable NSURLSessionDataTask *)SafePOSTWithJson:(nullable NSString *)URLString
                                           parameters:(nullable id)parameters
                                              success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id _Nullable responseObject))success
                                              failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure {
    APIManager *manager = [APIManager sharedManager];
    _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //todo 统一封装请求参数
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        
        //        [MBManager hideAlert];
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        [MBManager hideAlert];
        failure(task,error);
    }];
}

+ (nullable NSURLSessionDataTask *)SafePOSTWithJson:(nullable NSString *)authorization
                                                url:(nullable NSString *)URLString
                                         parameters:(nullable id)parameters
                                            success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id _Nullable responseObject))success
                                            failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure {
    APIManager *manager = [APIManager sharedManager];
    _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *tokens = [NSString stringWithFormat:@"%@%@", authorization, @";"];
    [_sharedManager.requestSerializer setValue:tokens forHTTPHeaderField:@"Authorization"];
    //todo 统一封装请求参数
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        
        //        [MBManager hideAlert];
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        [MBManager hideAlert];
        failure(task,error);
    }];
    
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError *_Nonnull error))failure{
    APIManager *manager = [APIManager sharedManager];
   _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //todo 统一封装请求参数
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        
//        [MBManager hideAlert];
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        [MBManager hideAlert];
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                           parameters:(id)parameters
                              picData:(void (^)(id<AFMultipartFormData> afMultipartFormData))formatDataBlock
                             progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                              success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{

    
    APIManager *manager = [APIManager sharedManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (formatDataBlock) {
            formatDataBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull progress) {
        uploadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)SafePOSTAuthorize:(NSString *)authorization
                                       url:(NSString *)URLString
                                parameters:(id)parameters
                                   picData:(void (^)(id<AFMultipartFormData> afMultipartFormData))formatDataBlock
                                  progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                                   success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                   failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
    
    APIManager *manager = [APIManager sharedManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString *tokens = [NSString stringWithFormat:@"%@%@", authorization, @";"];
    [_sharedManager.requestSerializer setValue:tokens forHTTPHeaderField:@"Authorization"];
    
    return [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (formatDataBlock) {
            formatDataBlock(formData);
        }
        
    } progress:^(NSProgress * _Nonnull progress) {
        uploadProgress(progress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    APIManager *manager = [APIManager sharedManager];
    
    return [manager GET:URLString parameters:parameters  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        failure(task,error);
    }];
}

+ (nullable NSURLSessionDataTask *)SafeGETWithJson:(nullable NSString *)authorization
                                       url:(nullable NSString *)URLString
                                parameters:(nullable id)parameters
                                   success:(nullable void (^)(NSURLSessionDataTask * __nullable task, id __nullable responseObject))success
                                   failure:(nullable void (^)(NSURLSessionDataTask * __nullable task, NSError * __nullable error))failure {
    APIManager *manager = [APIManager sharedManager];
    _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *tokens = [NSString stringWithFormat:@"%@%@", authorization, @";"];
    [_sharedManager.requestSerializer setValue:tokens forHTTPHeaderField:@"Authorization"];
    
    return [manager GET:URLString parameters:parameters  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo
        failure(task,error);
    }];
    
}

- (NSURLSessionDownloadTask *)downloadFileWithURL:(NSString*)requestURLString
                 parameters:(NSDictionary *)parameters
                  savedPath:(NSString*)savedPath
            downloadSuccess:(void (^)(NSURLResponse *response, NSURL *filePath))success
            downloadFailure:(void (^)(NSError *error))failure
           downloadProgress:(void (^)(NSProgress *downloadProgress))progress

{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURLString parameters:parameters error:nil];
    NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savedPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            failure(error);
        }else{
            success(response,filePath);
        }
    }];
    [task resume];
    
    return task;
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0;
}
@end
