//
//  chabaikeAppDelegate.h
//  chabaike
//
//  Created by Mac on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface chabaikeAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate>
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@end
