//
//  HttpClient.h
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class HttpReqBase;

typedef enum
{
    HttpStyleNorHttpReq = 0,
    HttpStyleExtendHttpReq
}
HttpStyle;

typedef enum {
    HttpMethodTypePost = 0,
    HttpMethodTypeGet,
    HttpMethodTypeHead,
    HttpMethodTypePut,
    HttpMethodTypePatch,
    HttpMethodTypeDelete
}
HttpMethodType;

@interface HttpClient : NSObject


+(instancetype) instance;

-(void)sendHttpRequest:(HttpReqBase *)theHttpReq;

-(void)sendHttpRequestInExtend:(HttpReqBase *)theHttpReq;


@end
