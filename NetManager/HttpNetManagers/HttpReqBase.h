//
//  HttpReqBase.h
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "AFNetworking.h"


typedef void (^SuccessBlock)(id data);
typedef void (^FailureBlock)(NSError *error);

@interface HttpReqBase : NSObject
{
    NSString *_relativeURLPathStr;
    NSMutableDictionary *_paramsDic;
    NSMutableDictionary *_paramsInHttpHeadDic;
    HttpMethodType _methodType;
    NSDictionary *_jsonResultDic;
    
}

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

//可以进行 暂停，恢复，取消等操作
@property (nonatomic, weak) AFHTTPSessionManager *curOperation;

-(void)addExtParam:(NSString *)key withValue:(id)value;

-(void)addExtParamInHttpHeader:(NSString *)key withValue:(id)value;

-(void)setSuccessBlock:(SuccessBlock)theSuccessBlock failureBlock:(FailureBlock)theFailureBlock;

-(void)sendRequest;

-(void)sendRequestInExtend;

-(NSString *)relativeURLPathStr;

-(NSDictionary *)paramsDic;

-(NSDictionary *)extParamsInHttpHeader;

-(HttpMethodType)methodType;

-(void)genSign;

-(void)onSuccessWithData:(id)backData;

#pragma mark - ResonseParse
-(void)onSuccessWithDataInExtend:(id)backData;

//-(void)onSuccessWithDataInUpDownLoader:(id)backData andReqOperation:(AFHTTPRequestOperation *)requestOp;

-(void)onFailureWithException:(NSError *)error;


-(NSString *)getIdentifyFromUrlPath:(NSString *)urlPath;

//缓存的
-(id)getCachedDataFromLocal;

-(id)getCachedDataFromLocalWithParam:(NSString *)theParam;
@end
