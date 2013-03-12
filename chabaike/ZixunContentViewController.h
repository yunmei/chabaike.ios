//
//  ZixunContentViewController.h
//  chashequ.ios
//
//  Created by ken on 13-3-6.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "TCWBEngine.h"
@interface ZixunContentViewController : UIViewController<
UIWebViewDelegate,
SinaWeiboDelegate,
SinaWeiboRequestDelegate
>

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong,nonatomic)UISwipeGestureRecognizer *swipeGesture;
@property (strong,nonatomic)NSString *zixunId;
@property (strong,nonatomic)UIWebView *contentWebView;
@property (strong,nonatomic)UILabel *contentTitleLable;
@property (strong,nonatomic)UIView *headerView;
@property (strong,nonatomic)UILabel *detailLable;
@property (strong,nonatomic)NSString *shareContent;
@property (strong,nonatomic) UIImageView *shareViewBar;

@property (strong, nonatomic) UITextView *textView;

@property (strong, nonatomic) UIView *shareView;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@property (strong, nonatomic) TCWBEngine *TCWeiboEngine;
- (void) addButton;

- (void) addShareView;

- (void) share:(UIButton*) sender;

- (void) removeShare:(UIButton*) sender;

- (void) sendShare:(UIButton*) sender;

- (void) exitShare:(UIButton*) sender;

@end
