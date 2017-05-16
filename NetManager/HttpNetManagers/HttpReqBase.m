//
//  HttpReqBase.m
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "HttpReqBase.h"
#import "YRJSONAdapter.h"
#import "AFNetworkReachabilityManager.h"
static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
static NSString * AFPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}
@implementation NSString (compare)


-(NSComparisonResult)XCompare:(NSString*)other
{
    return [self compare:other options:NSForcedOrderingSearch];
}
@end

@implementation HttpReqBase
//默认会添加AccessToken等默认参数
-(id)init
{
    self = [super init];
    if (self) {
        //
        _relativeURLPathStr = nil;
        _paramsDic = [[NSMutableDictionary alloc] init];
        _paramsInHttpHeadDic = [[NSMutableDictionary alloc] init];
        _methodType = HttpMethodTypePost;
        _jsonResultDic = nil;
        [self setUp];
        [self addCommonParam];
    }
    
    return self;
}

#pragma mark - PrepareForRequest
////子类重写
-(void)setUp
{
    _relativeURLPathStr = @"";
    _methodType = HttpMethodTypePost;
}

//添加公共参数，URL请求中，不变的参数都放在这个方法中添加
-(void)addCommonParam
{
    [self addExtParam:@"key" withValue:kJuheKey];
    [self addExtParam:@"v" withValue:@"1.0"];
    
//    NSDate * date = [NSDate date];
//    NSInteger timeString = [date timeIntervalSince1970];//转为字符型
//    [self addExtParam:@"timestamp" withValue:[NSString stringWithFormat:@"%ld",(long)timeString]];
 
}
//子类添加参数
-(void)addExtParam:(NSString *)key withValue:(id)value
{
    if (value) {
        [_paramsDic setValue:value forKey:key];
    }
}
//子类添加头部参数
-(void)addExtParamInHttpHeader:(NSString *)key withValue:(id)value
{
    if (value) {
        [_paramsInHttpHeadDic setObject:value forKey:key];
    }
}
//请求结果返回
-(void)setSuccessBlock:(SuccessBlock)theSuccessBlock failureBlock:(FailureBlock)theFailureBlock
{
    self.successBlock = theSuccessBlock;
    self.failureBlock = theFailureBlock;
}

-(void)sendRequest
{
    
//    [self genSign];
    [[HttpClient instance] sendHttpRequest:self];
}

-(void)sendRequestInExtend
{
//    [self genSign];
    [[HttpClient instance] sendHttpRequestInExtend:self];
}

//子类从写
-(NSString *)relativeURLPathStr
{
    return _relativeURLPathStr;
}

-(NSDictionary *)paramsDic
{
    return _paramsDic;
}

-(NSDictionary *)extParamsInHttpHeader
{
    return _paramsInHttpHeadDic;
}

-(HttpMethodType)methodType
{
    return _methodType;
}
//检查网络
-(void)checkNetWorkState
{
    BOOL netReachable = [[AFNetworkReachabilityManager sharedManager] isReachable];
    if (!netReachable) {
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用"];
    }
}

/*生成Sign签名参数
 
 ①　将请求的所有参数（包括系统参数和应用参数，不包含sign和资源类型文件）依照key name做快速排序
 ②　将排序后的参数使用&符号，依照key=value的形式连接成一个字符串，并在字符串尾拼接app secret
 ③　计算拼接后字符串的MD5值，作为本次请求的sign
 */
#pragma mark - genSign
-(void)genSign
{
    NSArray *keysAry = [_paramsDic allKeys];
    NSArray *sortedKeysAry = [keysAry sortedArrayUsingSelector:@selector(XCompare:)];
    
    NSMutableString *paramValuesStr = [[NSMutableString alloc] initWithString:@""];
    
    NSInteger index = 0;
    
    NSInteger count = sortedKeysAry.count;
    for(NSString *key in sortedKeysAry){
        
        if (index ==count-1) {
            [paramValuesStr appendFormat:@"%@=%@",key ,[_paramsDic objectForKey:key]];
        }else
        {
            [paramValuesStr appendFormat:@"%@=%@&",key ,[_paramsDic objectForKey:key]];
        }
        index++;
    }
    
    [paramValuesStr appendString:@""];
    NSString *encodedStr = AFPercentEscapedQueryStringValueFromStringWithEncoding(paramValuesStr, NSUTF8StringEncoding);

    NSString *signStr = [encodedStr md5Hash:32];
    [self addExtParam:@"sign" withValue:[signStr lowercaseString]];
}
#pragma mark - ResonseParse
-(void)onSuccessWithData:(id)backData
{
    //将返回结果编码并输出到日志
    NSString *dataStr = [[NSString alloc] initWithData:backData encoding:NSUTF8StringEncoding];
    if ([backData isKindOfClass:[NSDictionary class]]) {
        _jsonResultDic = backData;
    }else {
        _jsonResultDic = [[dataStr dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
    }
    
    if (_jsonResultDic != nil) {
        id model = [self onParseData:_jsonResultDic];

        
        if (self.successBlock) {
            self.successBlock(model);
        }
    }else {
        NSString *msg = dataStr;
        NSString *detail = [NSString stringWithFormat:@"%@:\nURL:%@\nParams:%@\nMessage:%@\n",NSStringFromClass([self class]),_relativeURLPathStr,_paramsDic.description,msg];
        NSDictionary *errorInfo = @{NSLocalizedDescriptionKey: msg,
                                    NSLocalizedRecoverySuggestionErrorKey: detail};
        NSError *error = [NSError errorWithDomain:@"" code:400 userInfo:errorInfo];
        [self onFailureWithException:error];
    }
}

#pragma mark - ResonseParse
-(void)onSuccessWithDataInExtend:(id)backData
{
    //将返回结果编码并输出到日志
    NSString *dataStr = [[NSString alloc] initWithData:backData encoding:NSUTF8StringEncoding];
    _jsonResultDic = [dataStr objectFromJSONString];
    if (_jsonResultDic != nil) {
        id model = [self onParseData:_jsonResultDic];

        if (self.successBlock) {
            self.successBlock(model);
        }
    }else {
        NSString *msg = dataStr;
        NSString *detail = [NSString stringWithFormat:@"%@:\nURL:%@\nParams:%@\nMessage:%@\n",NSStringFromClass([self class]),_relativeURLPathStr,_paramsDic.description,msg];
        NSDictionary *errorInfo = @{NSLocalizedDescriptionKey: msg,
                                    NSLocalizedRecoverySuggestionErrorKey: detail};
        NSError *error = [NSError errorWithDomain:@"" code:400 userInfo:errorInfo];
        [self onFailureWithException:error];
    }
}
//子类重写解析自己的数据
-(id)onParseData:(id)jsonData
{
    return nil;
}

-(void)onFailureWithException:(NSError *)error
{
    if (self.failureBlock) {
        self.failureBlock(error);
    }
    
    [self checkNetWorkState];
}


-(NSString *)getIdentifyFromUrlPath:(NSString *)urlPath
{
    NSMutableString *theIndentifyStr = [[NSMutableString alloc] initWithString:urlPath];
    
    [theIndentifyStr replaceOccurrencesOfString:@"/" withString:@"_" options:NSCaseInsensitiveSearch range:NSMakeRange(0, urlPath.length-1)];
    
    return theIndentifyStr;
}

//子类重写 ->
-(id)getCachedDataFromLocal
{
    return [self getCachedDataFromLocalWithParam:nil];
}

-(id)getCachedDataFromLocalWithParam:(NSString *)theParam
{
    return nil;
}




@end
