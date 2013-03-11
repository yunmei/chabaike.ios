//
//  WebViewController.h
//  chabaike
//
//  Created by Mac on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSURL *openUrl;
@property (strong, nonatomic) NSString *showTitle;
@property (strong, nonatomic) IBOutlet UIWebView *webShowView;

@end
