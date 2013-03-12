//
//  ImageDownload.m
//  chashequ.ios
//
//  Created by ken on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "ImageDownload.h"

@implementation ImageDownload

+(void)downloadImage:(NSString *)urlString imageName:(NSString *)imageName
{
    NSURL *url = [NSURL URLWithString:urlString];
    UIImage *img = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url]];
   //Doucumnet
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",paths);
    //写入图片
    NSString *uniquePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:imageName];
    //将图片写入
    [UIImagePNGRepresentation(img) writeToFile:uniquePath atomically:YES];
}

+(UIImage *)readImage:(NSString *)imageName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *uniquePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:imageName];
    NSData *data = [NSData dataWithContentsOfFile:uniquePath];
    UIImage *img = [UIImage imageWithData:data];
    return img;
}
@end
