//
//  DZNetworkHelper.m
//  onebyone
//
//  Created by Gavin on 2018/1/24.
//  Copyright © 2018年 ShenZhen GaoShengTong Computer software development Co., LTD. All rights reserved.
//

#import "DZNetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation DZNetworkHelper

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(DZNetworkStatus)networkStatus {
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType status) {
    }];
}

+ (BOOL)isNetwork {
    return [PPNetworkHelper isNetwork];
}

+ (BOOL)isWWANNetwork {
    return [PPNetworkHelper isWWANNetwork];
}

+ (BOOL)isWiFiNetwork {
    return [PPNetworkHelper isWiFiNetwork];
}

+ (void)openLog {
    [PPNetworkHelper openLog];
}

+ (void)closeLog {
    [PPNetworkHelper closeLog];
}

+ (void)cancelAllRequest {
    [PPNetworkHelper cancelAllRequest];
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    [PPNetworkHelper cancelRequestWithURL:URL];
}

#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(DZHttpRequestSuccess)success
                  failure:(DZHttpRequestFailed)failure {
    NSMutableString *paramsString = [NSMutableString stringWithCapacity:1];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paramsString appendFormat:@"%@=%@",key,obj];
        [paramsString appendString:@"&"];
    }];
    //判断是否拼接路径，如果字符串里有http就不拼接，没有就拼接
    NSString *urlStr;
    if ([URL rangeOfString:@"?"].location != NSNotFound) {
        urlStr=[NSString stringWithFormat:@"%@&%@",URL,paramsString];
    }else{
        urlStr=[NSString stringWithFormat:@"%@?%@",URL,paramsString];
    }
    //    urlStr=[NSString stringWithFormat:@"%@?%@",path,paramsString];
    urlStr = [urlStr substringToIndex:urlStr.length-1];
    NSLog(@"getUrl==>%@",urlStr);
    return  [PPNetworkHelper GET:URL parameters:parameters success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(DZHttpRequestSuccess)success
                   failure:(DZHttpRequestFailed)failure {
    
    NSMutableString *paramsString = [NSMutableString stringWithCapacity:1];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [paramsString appendFormat:@"%@=%@",key,obj];
        [paramsString appendString:@"&"];
    }];
    //判断是否拼接路径，如果字符串里有http就不拼接，没有就拼接
    NSString *urlStr;
    if ([URL rangeOfString:@"?"].location != NSNotFound) {
        urlStr=[NSString stringWithFormat:@"%@&%@",URL,paramsString];
    }else{
        urlStr=[NSString stringWithFormat:@"%@?%@",URL,paramsString];
    }
    //    urlStr=[NSString stringWithFormat:@"%@?%@",path,paramsString];
    urlStr = [urlStr substringToIndex:urlStr.length-1];
    NSLog(@"postUrl==>%@",urlStr);
    
    return  [PPNetworkHelper POST:URL parameters:parameters success:success failure:failure];
}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(DZHttpRequestCache)responseCache
                  success:(DZHttpRequestSuccess)success
                  failure:(DZHttpRequestFailed)failure {
    return [PPNetworkHelper GET:URL parameters:parameters responseCache:responseCache success:success failure:failure];
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(DZHttpRequestCache)responseCache
                   success:(DZHttpRequestSuccess)success
                   failure:(DZHttpRequestFailed)failure {
    return [PPNetworkHelper POST:URL parameters:parameters responseCache:responseCache success:success failure:failure];
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(DZHttpProgress)progress
                                success:(DZHttpRequestSuccess)success
                                failure:(DZHttpRequestFailed)failure {
    
    return [PPNetworkHelper uploadFileWithURL:URL parameters:parameters name:name filePath:filePath progress:progress success:success failure:failure];
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(DZHttpProgress)progress
                                  success:(DZHttpRequestSuccess)success
                                  failure:(DZHttpRequestFailed)failure {
    NSLog(@"%@",URL);
    return  [PPNetworkHelper uploadImagesWithURL:URL parameters:parameters name:name images:images fileNames:fileNames imageScale:imageScale imageType:imageType progress:progress success:success failure:failure];
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(DZHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(DZHttpRequestFailed)failure {
    return  [PPNetworkHelper downloadWithURL:URL fileDir:fileDir progress:progress success:success failure:failure];
}

/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [PPNetworkHelper load];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    [PPNetworkHelper initialize];
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    [PPNetworkHelper setAFHTTPSessionManagerProperty:sessionManager];
}

+ (void)setRequestSerializer:(DZRequestSerializer)requestSerializer {
    PPRequestSerializer requestS;
    switch (requestSerializer) {
        case DZRequestSerializerJSON:
            requestS = PPRequestSerializerJSON;
            break;
        case DZRequestSerializerHTTP:
            requestS = PPRequestSerializerHTTP;
        default:
            break;
    }
    [PPNetworkHelper setRequestSerializer:requestS];
}

+ (void)setResponseSerializer:(DZResponseSerializer)responseSerializer {
    PPResponseSerializer responseS;
    switch (responseSerializer) {
        case DZResponseSerializerJSON:
            responseS = PPResponseSerializerJSON;
            break;
        case DZRequestSerializerHTTP:
            responseS = PPResponseSerializerHTTP;
        default:
            break;
    }
    [PPNetworkHelper setResponseSerializer:responseS];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    [PPNetworkHelper setRequestTimeoutInterval:time];
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [PPNetworkHelper setValue:value forHTTPHeaderField:field];
}

+ (void)openNetworkActivityIndicator:(BOOL)open {
    [PPNetworkHelper openNetworkActivityIndicator:open];
}
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    [PPNetworkHelper setSecurityPolicyWithCerPath:cerPath validatesDomainName:validatesDomainName];
}

@end
