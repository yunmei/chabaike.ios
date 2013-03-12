//
//  ViewController.h
//  chashequ.ios
//
//  Created by bevin chen on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "SBJson.h"
#import "ZixunContentViewController.h"
#import "PullToRefreshTableView.h"

@interface ViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIButton *btnTab1;
@property (strong, nonatomic) UIButton *btnTab2;
@property (strong, nonatomic) UIButton *btnTab3;
@property (strong, nonatomic) UIButton *btnTab4;
@property (strong, nonatomic) UIButton *btnTab5;
@property (strong, nonatomic) UIImageView *pageControlView;
@property (strong, nonatomic) UIButton *currentTabBtn;
@property (strong, nonatomic) UIScrollView *tabScrollView;
@property (strong, nonatomic) UIScrollView *adScrollView;
@property (strong, nonatomic) UILabel *adLabel;
@property (strong, nonatomic) UITableView *refreshTableView1;
@property (strong, nonatomic) PullToRefreshTableView *refreshTableView2;
@property (strong, nonatomic) PullToRefreshTableView *refreshTableView3;
@property (strong, nonatomic) PullToRefreshTableView *refreshTableView4;
@property (strong, nonatomic) PullToRefreshTableView *refreshTableView5;
@property (strong, nonatomic) NSMutableArray *tab1Array;
@property (strong, nonatomic) NSMutableArray *tab2Array;
@property (strong, nonatomic) NSMutableArray *tab3Array;
@property (strong, nonatomic) NSMutableArray *tab4Array;
@property (strong, nonatomic) NSMutableArray *tab5Array;
@property (strong, nonatomic) NSMutableArray *adArray;
@property (strong, nonatomic) UIPageControl *adPageControl;
@end
