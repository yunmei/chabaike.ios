//
//  Utility.m
//  iosdev
//
//  Created by chen bevin on 12-2-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utility

//创建MD5字符串
+(NSString *)createdMD5:(NSString *)signString
{
    const char*cStr =[signString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ]; 
}



//测试网络连接
+(BOOL)connectedToNetWork
{
    //return NO;
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));//bzero:设置zeroaddress为0。且包括‘\0’
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);    
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) 
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}//创建PostUrl
+(NSString *)createPostUrl:(NSMutableDictionary *)params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

//获取请求数据
+(NSData *)getResultData:(NSMutableDictionary *)params
{
    NSString *postUrl=[Utility createPostUrl:params];
    //NSLog(@"postUrl:%@", postUrl);
    NSError *error;
    NSURLResponse *theResponse;
    NSString *requestUrl = [NSString stringWithFormat:@"%@?apikey=%@&format=json&method=system.feedback", BASEURL,APP_KEY];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[postUrl dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&error];
    
    
}

//处理图片圆角
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}
+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

/**
 格式化时间
 timeSeconds 为0时表示当前时间,可以传入你定义的时间戳
 timeFormatStr为空返回当当时间戳,不为空返回你写的时间格式(yyyy-MM-dd HH:ii:ss)
 setTimeZome ([NSTimeZone systemTimeZone]获得当前时区字符串)
 */
+(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr{
    NSString *date_string;
    NSDate *time_str;
    if ( timeSeconds>0 ) {
        time_str = [NSDate dateWithTimeIntervalSince1970:timeSeconds];
    }else{
        time_str= [[NSDate alloc] init];
    }
    if ( timeFormatStr==nil) {
        date_string = [NSString stringWithFormat:@"%d", (long)[time_str timeIntervalSince1970]];
    }else{
        NSDateFormatter *date_format_str = [[NSDateFormatter alloc] init];
        [date_format_str setDateFormat:timeFormatStr];
        if( timeZoneStr!=nil ){
            [date_format_str setTimeZone:[NSTimeZone timeZoneWithName:timeZoneStr]];
        }
        date_string = [date_format_str stringFromDate:time_str];
    }
    return date_string;
}
@end
