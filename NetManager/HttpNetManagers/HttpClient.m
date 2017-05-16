//
//  HttpClient.m
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "HttpClient.h"
#import "HttpReqBase.h"


@implementation HttpClient
{
    AFHTTPSessionManager *_norHttpManager;      //普通请求
    AFHTTPSessionManager *_extendHttpManager;   //辅助请求（如：登录，注册，获取Token，Session等操作）
    
    NSURL *_upDownLoadBaseURL;
    NSURL *_normalBaseURL;
    NSURL *_extendBaseURL;
}

+(instancetype)instance {
    
    static HttpClient *httpClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpClient = [[self alloc] initSingleton];
    });
    return httpClient;
    
}

-(id)initSingleton
{
    self = [super init];
    if (self) {
        
        _normalBaseURL = [NSURL URLWithString:kURLMain];
        _norHttpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:_normalBaseURL];
        _norHttpManager.requestSerializer.timeoutInterval = 30;
        _norHttpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _norHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _extendBaseURL = [NSURL URLWithString:@""];
        _extendHttpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:_extendBaseURL];
        _extendHttpManager.requestSerializer.timeoutInterval = 30;
        _extendHttpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _extendHttpManager.responseSerializer = [AFHTTPResponseSerializer serializer];

        //注册网络监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

//监听网络变换
- (void) networkStatusChange:(NSNotification *)notification{
    NSNumber *number = [notification.userInfo objectForKey:AFNetworkingReachabilityNotificationStatusItem];
    AFNetworkReachabilityStatus curStatus = number.integerValue;
    NSInteger count = 20;
    switch (curStatus) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            count = 20;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            count = 10;
            break;
        default:
            break;
    }
    [_norHttpManager.operationQueue setMaxConcurrentOperationCount:count];
    [_extendHttpManager.operationQueue setMaxConcurrentOperationCount:count];
}
//添加Http头信息（optional）
-(void)addHeadInfo:(NSDictionary *)headInfoDic forStyle:(HttpStyle)theStyle
{
    AFHTTPRequestSerializer *theRequestSerializer = nil;
    switch (theStyle) {

        case HttpStyleNorHttpReq:
        {
            theRequestSerializer = _norHttpManager.requestSerializer;
            break;
        }
        case HttpStyleExtendHttpReq:
        {
            theRequestSerializer = _extendHttpManager.requestSerializer;
            break;
        }
        default:
            break;
    }
    
    if (theRequestSerializer) {
        [headInfoDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            if ([obj isEqual:[NSNull null]] || [obj isKindOfClass:[NSNull class]]) {
                //默认值为[Null null], 作为清除该字段的标志
                [theRequestSerializer setValue:nil forHTTPHeaderField:key];
            }else {
                [theRequestSerializer setValue:obj forHTTPHeaderField:key];
            }
            
        }];
    }
    
}

-(void)sendHttpRequest:(HttpReqBase *)theHttpReq
{
    if (theHttpReq == nil) {
        NSAssert(NO, @"requestWithRequester方法的requester参数不能为空");
        return;
    }
    
    if ([theHttpReq isKindOfClass:[HttpReqBase class]]) {
        //
        NSLog(@"[theHttpReq relativeURLPathStr]  =  %@",[theHttpReq relativeURLPathStr]);
        //HttpHeader参数
        NSDictionary *theHeaderParamsDic = [theHttpReq extParamsInHttpHeader];
        [self addHeadInfo:theHeaderParamsDic forStyle:HttpStyleNorHttpReq];
        
        if ([theHttpReq methodType]==HttpMethodTypePost) {
            
            [_norHttpManager POST:[theHttpReq relativeURLPathStr] parameters:[theHttpReq paramsDic] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
#ifdef DEBUG
                NSString *dataStr = [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"HttpRequest\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\nHTTPHeader:  %@\nParams:\n%@\nHttpBody:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.originalRequest.HTTPMethod, task.originalRequest.allHTTPHeaderFields, [theHttpReq paramsDic], dataStr);
#endif
                
                
                
                [theHttpReq onSuccessWithData:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSLog(@"HttpError\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\n\ErrorInfo:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.currentRequest.HTTPMethod, error);
#endif
                
                
                [theHttpReq onFailureWithException:error];
                
            }];
            
        }else if ([theHttpReq methodType]==HttpMethodTypeGet) {
            [_norHttpManager GET:[theHttpReq relativeURLPathStr] parameters:[theHttpReq paramsDic] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"HttpResponse\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\nResponseData:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.originalRequest.HTTPMethod, dataStr);
#endif
                
                
                
                
                
                [theHttpReq onSuccessWithData:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSLog(@"HttpError\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\n\ErrorInfo:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.currentRequest.HTTPMethod, error);
#endif
                
                [theHttpReq onFailureWithException:error];
                
            }];
            
            
        }else {
            NSAssert(NO, @"不支持POST和GET以外的Http请求方法");
        }
        
    }
}


-(void)sendHttpRequestInExtend:(HttpReqBase *)theHttpReq
{
    if (theHttpReq == nil) {
        NSAssert(NO, @"requestWithRequester方法的requester参数不能为空");
        return;
    }
    
    if ([theHttpReq isKindOfClass:[HttpReqBase class]]) {
        //
        
        //HttpHeader参数
        NSDictionary *theHeaderParamsDic = [theHttpReq extParamsInHttpHeader];
        [self addHeadInfo:theHeaderParamsDic forStyle:HttpStyleExtendHttpReq];
        
        if ([theHttpReq methodType]==HttpMethodTypePost) {
            //
            [_extendHttpManager POST:[theHttpReq relativeURLPathStr] parameters:[theHttpReq paramsDic] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
#ifdef DEBUG
                NSString *dataStr = [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding];
                NSLog(@"HttpRequest\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\nHTTPHeader:  %@\nParams:\n%@\nHttpBody:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.originalRequest.HTTPMethod, task.originalRequest.allHTTPHeaderFields, [theHttpReq paramsDic], dataStr);
#endif
                
                
                [theHttpReq onSuccessWithData:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSLog(@"HttpError\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\n\ErrorInfo:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.currentRequest.HTTPMethod, error);
#endif
                [theHttpReq onFailureWithException:error];
                
            }];
            
            
            
        }else if ([theHttpReq methodType]==HttpMethodTypeGet) {
            
            [_extendHttpManager GET:[theHttpReq relativeURLPathStr] parameters:[theHttpReq paramsDic] progress:^(NSProgress * _Nonnull downloadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSLog(@"HttpResponse\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\nResponseData:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.originalRequest.HTTPMethod, dataStr);
#endif

                [theHttpReq onSuccessWithData:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
                //将返回结果编码并输出到日志
                NSLog(@"HttpError\n==========================↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓==========================\nHttpURL:     %@\nHttpMethod:  %@\n\ErrorInfo:\n%@\n==========================↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑==========================", task.originalRequest.URL, task.currentRequest.HTTPMethod, error);
#endif
                [theHttpReq onFailureWithException:error];
                
            }];
            
        }else {
            NSAssert(NO, @"不支持POST和GET以外的Http请求方法");
        }
        
    }
}





@end
