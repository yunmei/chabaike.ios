//
//  SlideViewController.m
//  chashequ.ios
//
//  Created by ken on 13-3-5.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "SlideViewController.h"
#import "MKNetworkEngine.h"
#import "YMGlobal.h"
#import "SBJson.h"
#import "ViewController.h"
@interface SlideViewController ()

@end

@implementation SlideViewController
@synthesize pageControl = _pageControl;
@synthesize pageScroll = _pageScroll;
@synthesize gotoMainViewButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.pageScroll];
    [self addImageToScrollView];
    [self.view addSubview:self.pageControl];
    // Do any additional setup after loading the view from its nib.
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.getSlideshow",@"method", nil];
//    MKNetworkOperation *op = [YMGlobal getOperation:params];
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//        SBJsonParser *parser = [[SBJsonParser alloc]init];
//        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
//        if([[object objectForKey:@"errorMessage"] isEqualToString:@"success"])
//        {
//            NSLog(@"data:%@",[object objectForKey:@"data"]);
//        }
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    [ApplicationDelegate.appEngine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(141, 424, 38, 36)];
    }
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;  
    return _pageControl;
}

-(UIScrollView *)pageScroll
{
    if(_pageScroll == nil)
    {
        _pageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
    }
    [_pageScroll setContentSize:CGSizeMake(self.view.frame.size.width * 3 , self.view.frame.size.height)];
    _pageScroll.delegate = self;
    _pageScroll.scrollEnabled = YES;
    _pageScroll.pagingEnabled = YES;
    return  _pageScroll;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) +1;
    if(scrollView.contentOffset.x == pageWidth * 2)
    {
        self.gotoMainViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.gotoMainViewButton setFrame:CGRectMake(0, 0, 320, 460)];
        [self.view addSubview:self.gotoMainViewButton];
        [self.gotoMainViewButton addTarget:self action:@selector(gotoMainView:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.gotoMainViewButton removeFromSuperview];
    }
    if(scrollView.contentOffset.x > pageWidth*2)
    {
        [self gotoMainView];
    }
    self.pageControl.currentPage = page;
}

-(void)addImageToScrollView
{
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 460)];
    NSLog(@"w%fh%f",self.view.frame.size.width,self.view.frame.size.height);
    [imgView1 setImage:[UIImage imageNamed:@"slide1.png"]];
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, 460)];
    [imgView2 setImage:[UIImage imageNamed:@"slide2.png"]];
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, 460)];
    [imgView3 setImage:[UIImage imageNamed:@"slide3.png"]];
    [self.pageScroll addSubview:imgView1];
    [self.pageScroll addSubview:imgView2];
    [self.pageScroll addSubview:imgView3];
}

-(void)gotoMainView:(id)sender
{
    ViewController *mainView = [[ViewController alloc]init];
    [self.navigationController pushViewController:mainView animated:YES];
}

-(void)gotoMainView
{
    ViewController *mainView = [[ViewController alloc]init];
    [self.navigationController pushViewController:mainView animated:YES];
}
@end
