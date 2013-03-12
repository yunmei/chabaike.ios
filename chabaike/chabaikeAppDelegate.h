//
//  AppDelegate.h
//  chashequ.ios
//
//  Created by bevin chen on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MKNetworkKit.h"
#define ApplicationDelegate ((chabaikeAppDelegate *)[UIApplication sharedApplication].delegate)
@class ViewController;
@interface chabaikeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) MKNetworkEngine *appEngine;
@end
