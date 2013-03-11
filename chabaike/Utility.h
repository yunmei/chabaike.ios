//
//  Utility.h
//  iosdev
//
//  Created by chen bevin on 12-2-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
@interface Utility : NSObject

+(NSString *)createdMD5:(NSString *)params;

+(BOOL)connectedToNetWork;
+(NSString *)createPostUrl:(NSMutableDictionary *)params;
+(NSData *)getResultData:(NSMutableDictionary *)params;
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size;
+(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr;
@end
