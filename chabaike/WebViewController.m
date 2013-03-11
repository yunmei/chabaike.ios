//
//  WebViewController.m
//  chabaike
//
//  Created by Mac on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize openUrl;
@synthesize webShowView;
@synthesize showTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webShowView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:self.openUrl];
    [self.webShowView loadRequest:request];
    
    self.navigationItem.title = self.showTitle;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleBordered target:self action:@selector(closeView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStyleBordered target:self action:@selector(backView)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewDidUnload
{
    [self setWebShowView:nil];
    [self setOpenUrl:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)closeView
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)backView
{
    [self.webShowView goBack];
}
@end
