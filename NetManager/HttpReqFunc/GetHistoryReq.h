//
//  GetHistoryReq.h
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import "HttpReqBase.h"

@interface GetHistoryReq : HttpReqBase
-(void)addParametersFuncMonth:(NSString *)month andDay:(NSString *)day;
@end
