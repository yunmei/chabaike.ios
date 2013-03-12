//
//  ImageDownload.h
//  chashequ.ios
//
//  Created by ken on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDownload : NSObject

+(void)downloadImage:(NSString *)url
           imageName:(NSString *)imageName;

//+(void)addImageToSandbox:

+(UIImage *)readImage:(NSString *)imageName;
@end
