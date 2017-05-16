//
//  HttpModel.h
//  NetManager
//
//  Created by 郭榜 on 2017/5/16.
//  Copyright © 2017年 com.Madman_bg.init. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpModel : NSObject
@property (nonatomic,assign) NSInteger result;   //http成功标志
@property (nonatomic,strong) NSString * message; //数据消息内容
@property (nonatomic, strong) id formatPayload;   //解析好的数据
@end
