//
//  UUID.m
//  NashWorkSpace
//
//  Created by 郭榜 on 16/7/4.
//  Copyright © 2016年 yilv. All rights reserved.
//

#import "UUID.h"
#import "KeyChainStore.h"

#import <AdSupport/AdSupport.h>


@implementation UUID
+(NSString *)getUUID

{


//    NSString * strUUID = (NSString *)[KeyChainStore load:KUuidKey];
//    
//    
//    
//    //首次执行该方法时，uuid为空
//    
//    if ([strUUID isEqualToString:@""] || !strUUID)
//        
//    {
//        
//        //生成一个uuid的方法
//        
//        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
//        
//        
//        
//        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
//        
//        
//        
//        //将该uuid保存到keychain
//        
//        [KeyChainStore save:KUuidKey data:strUUID];
//        
//        
//        
//    }
    
    
    
    ASIdentifierManager* adManager = [ASIdentifierManager sharedManager];
    NSString * strUUID = adManager.advertisingIdentifier.UUIDString;
    
    NSLog(@"idfa ==  %@", strUUID);
    
    
    return strUUID;
    
}




@end
