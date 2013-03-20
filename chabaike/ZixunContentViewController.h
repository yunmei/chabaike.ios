//
//  ZixunContentViewController.h
//  chashequ.ios
//
//  Created by ken on 13-3-6.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UMSocialSnsService.h"
#import "SearchContentViewController.h"
#import "DBsqlite.h"

#define COMEFROM_INDEX    0       //内容根据传递的ID请求获得
#define COMEFROM_COLLECT  1       //内容从收藏的数据库里调取
#define COMEFROM_BROWSE   2       //内容从浏览记录的数据库里调取

@interface ZixunContentViewController : UIViewController<
UIWebViewDelegate
>

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong,nonatomic)UISwipeGestureRecognizer *swipeGesture;
@property (strong,nonatomic)NSString *zixunId;
@property (strong,nonatomic)UIWebView *contentWebView;
@property (strong,nonatomic)UILabel *contentTitleLable;
@property (strong,nonatomic)UIView *headerView;
@property (strong,nonatomic)UILabel *detailLable;
@property (strong,nonatomic)NSString *shareContent;
@property (strong,nonatomic)NSString *ziXunContent;
@property (strong,nonatomic)NSMutableDictionary *contentInDetail;
//加一个标识字符串，判断内容页是从首页还是收藏页
@property int sourceViewNumber;

@property (strong,nonatomic)NSString *contentId;
@end
