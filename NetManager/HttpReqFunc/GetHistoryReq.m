//
//  GetHistoryReq.m
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "GetHistoryReq.h"

@implementation GetHistoryReq

-(void)setUp
{
    _relativeURLPathStr = @"/japi/toh";
    _methodType = HttpMethodTypeGet;
    
}

-(void)addParametersFuncMonth:(NSString *)month andDay:(NSString *)day {
    
    [self addExtParam:@"month" withValue:month];
    [self addExtParam:@"day" withValue:day];
    [self sendRequest];
 
}


//子类重写解析自己的数据
-(id)onParseData:(id)jsonData
{
    if (jsonData) {
        HttpModel *httpResultM = [[HttpModel alloc] init];
#ifdef DEBUG
        NSLog(@"%@",jsonData);
#endif
        if([jsonData isKindOfClass:[NSDictionary class]]){
            
            httpResultM.result = [[jsonData objectForKey:@"error_code"] integerValue];
//            httpResultM.message = [jsonData description];
            httpResultM.message = [jsonData objectForKey:@"reason"];
            
            if (httpResultM.result==0) {
                
                httpResultM.formatPayload = [jsonData objectForKey:@"result"];
            }
        }
        return httpResultM;
    }
    return nil;
}

@end
