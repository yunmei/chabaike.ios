//
//  SlideViewController.h
//  chashequ.ios
//
//  Created by ken on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *pageScroll;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) UIButton *gotoMainViewButton;
@end
