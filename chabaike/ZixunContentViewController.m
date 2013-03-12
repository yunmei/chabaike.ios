//
//  ZixunContentViewController.m
//  chashequ.ios
//
//  Created by ken on 13-3-6.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "ZixunContentViewController.h"
#import "YMGlobal.h"
#import "SBJson.h"

@interface ZixunContentViewController ()

@end

@implementation ZixunContentViewController
@synthesize swipeGesture = _swipeGesture;
@synthesize zixunId;
@synthesize contentWebView = _contentWebView;
@synthesize contentTitleLable = _contentTitleLable;
@synthesize detailLable;
@synthesize contentScrollView;
@synthesize shareContent;
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
    // Do any additional setup after loading the view from its nib.
    [self.view addGestureRecognizer:self.swipeGesture];
    //生成头部绿色背景
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320, 120)];
    [self.headerView setBackgroundColor:[UIColor colorWithRed:61.0/255.0 green:157.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [self.contentScrollView addSubview:self.headerView];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.getNewsContent",@"method",self.zixunId,@"id", nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"zixuncontent%@",[completedOperation responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            NSMutableDictionary *data = [object objectForKey:@"data"];
            NSString *titleContent = [data objectForKey:@"title"];
            NSString *content = [data objectForKey:@"wap_content"];
            NSString *weiboUrl = [data objectForKey:@"weiboUrl"];
            if(titleContent)
            {
                //计算内容所需要的高度
                CGSize size = [titleContent sizeWithFont:[UIFont systemFontOfSize:22.0] constrainedToSize:CGSizeMake(280.0, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
                CGFloat height = size.height;
                self.contentTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, height)];
                [self.contentTitleLable setNumberOfLines:0];
                self.contentTitleLable.text = titleContent;
                self.contentTitleLable.backgroundColor = [UIColor clearColor];
                [self.contentTitleLable setFont:[UIFont systemFontOfSize:22.0]];
                [self.contentTitleLable setTextColor:[UIColor whiteColor]];
                [self.headerView addSubview:self.contentTitleLable];
                //设置来源，作者，发表时间
                self.detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, height+20, 280, 20)];
                [self.detailLable setFont:[UIFont systemFontOfSize:14.0]];
                [self.detailLable setText:[NSString stringWithFormat:@"%@    %@",[data objectForKey:@"author"],[data objectForKey:@"create_time"]]];
                [self.detailLable setBackgroundColor:[UIColor clearColor]];
                [self.detailLable setTextColor:[UIColor whiteColor]];
                [self.headerView  addSubview:self.detailLable];
                [self.headerView setFrame:CGRectMake(0,0,320, height+45)];
                //设置分享内容
                self.shareContent = [titleContent stringByAppendingString:weiboUrl];
                if(content)
                {
                    self.contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height+45, 320, 295)];
                    self.contentWebView.delegate = self;
                    [self.contentWebView loadHTMLString:content baseURL:[NSURL URLWithString:@"about:blank"]];
                    
                }
            }

        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    //生成底部返回和分享按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 415, 160, 45)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ContentBack.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(160, 415, 160, 45)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"ContentShare.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(contentShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [self.view addSubview:backButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UISwipeGestureRecognizer *)swipeGesture
{
    if(_swipeGesture == nil)
    {
        _swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
    }
    _swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    return _swipeGesture;
}

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    NSString *fitHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    frame.size.height = [fitHeight floatValue];
    webView.frame = frame;
    [self.contentScrollView setContentSize:CGSizeMake(320, frame.size.height + 120)];
    [self.contentScrollView addSubview:webView];
}

- (void)viewDidUnload {
    [self setContentScrollView:nil];
    [super viewDidUnload];
}


//点击分享
- (void)contentShare:(id)sender
{
    [UMSocialSnsService presentSnsController:self
                                    appKey:@"4fab36cf527015375d000049"
                                    shareText:self.shareContent
                                    shareImage:nil
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQzone,UMShareToRenren,UMShareToQzone,UMShareToDouban,UMShareToTencent,UMShareToSina,nil]
                                    delegate:nil];
}

@end
