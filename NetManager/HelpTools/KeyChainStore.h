//
//  KeyChainStore.h
//  NashWorkSpace
//
//  Created by 郭榜 on 16/7/4.
//  Copyright © 2016年 yilv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainStore : NSObject
+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;
@end
