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
@synthesize ziXunContent;
@synthesize contentInDetail = _contentInDetail;
@synthesize sourceViewNumber;
@synthesize contentId;

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
    if([UIScreen mainScreen].bounds.size.height >480)
    {
        [self.contentScrollView setFrame:CGRectMake(0, 0, 320, 415+([UIScreen mainScreen].bounds.size.height -480))];
    }
    [self.view addGestureRecognizer:self.swipeGesture];
    //生成头部绿色背景
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320, 120)];
    [self.headerView setBackgroundColor:[UIColor colorWithRed:61.0/255.0 green:157.0/255.0 blue:1.0/255.0 alpha:1.0]];
    [self.contentScrollView addSubview:self.headerView];
    //根据字符标识，当从首页打开的时候
    if(self.sourceViewNumber == COMEFROM_INDEX)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.getNewsContent",@"method",self.zixunId,@"id", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
            if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                NSMutableDictionary *data = [object objectForKey:@"data"];
                [self.contentInDetail setObject:[data objectForKey:@"id"] forKey:@"id"];
                [self.contentInDetail setObject:[data objectForKey:@"title"] forKey:@"title"];
                [self.contentInDetail setObject:[data objectForKey:@"wap_content"] forKey:@"wap_content"];
                [self.contentInDetail setObject:[data objectForKey:@"create_time"] forKey:@"create_time"];
                [self.contentInDetail setObject:[data objectForKey:@"weiboUrl"] forKey:@"weiboUrl"];
                [self.contentInDetail setObject:[data objectForKey:@"author"] forKey:@"author"];
                DBsqlite *db = [[DBsqlite alloc]init];
                if([db connectFav])
                {
                    if([db exec:@"CREATE TABLE IF NOT EXISTS browseRecord ('id','title','wap_content','create_time','weiboUrl','author');"])
                    {
                        NSString *browseQuery = [NSString stringWithFormat:@"INSERT INTO browseRecord ('id','title','wap_content','create_time','weiboUrl','author') VALUES ('%@','%@','%@','%@','%@','%@')",[self.contentInDetail objectForKey:@"id"],[self.contentInDetail objectForKey:@"title"],[self.contentInDetail objectForKey:@"wap_content"],[self.contentInDetail objectForKey:@"create_time"],[self.contentInDetail objectForKey:@"weiboUrl"],[self.contentInDetail objectForKey:@"author"]];
                        [db exec:browseQuery];
                    }
                    
                }
                if([self.contentInDetail objectForKey:@"title"])
                {
                    //计算内容所需要的高度
                    CGSize size = [[self.contentInDetail objectForKey:@"title"] sizeWithFont:[UIFont systemFontOfSize:22.0] constrainedToSize:CGSizeMake(280.0, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
                    CGFloat height = size.height;
                    self.contentTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, height)];
                    [self.contentTitleLable setNumberOfLines:0];
                    self.contentTitleLable.text = [self.contentInDetail objectForKey:@"title"];
                    self.contentTitleLable.backgroundColor = [UIColor clearColor];
                    [self.contentTitleLable setFont:[UIFont systemFontOfSize:22.0]];
                    [self.contentTitleLable setTextColor:[UIColor whiteColor]];
                    [self.headerView addSubview:self.contentTitleLable];
                    //设置来源，作者，发表时间
                    self.detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, height+20, 280, 20)];
                    [self.detailLable setFont:[UIFont systemFontOfSize:14.0]];
                    [self.detailLable setText:[NSString stringWithFormat:@"%@    %@",[self.contentInDetail objectForKey:@"author"],[self.contentInDetail objectForKey:@"create_time"]]];
                    [self.detailLable setBackgroundColor:[UIColor clearColor]];
                    [self.detailLable setTextColor:[UIColor whiteColor]];
                    [self.headerView  addSubview:self.detailLable];
                    [self.headerView setFrame:CGRectMake(0,0,320, height+45)];
                    //设置分享内容
                    self.shareContent = [[self.contentInDetail objectForKey:@"title"] stringByAppendingString:[self.contentInDetail objectForKey:@"weiboUrl"]];
                    if([self.contentInDetail objectForKey:@"wap_content"])
                    {
                        self.ziXunContent = [self.contentInDetail objectForKey:@"wap_content"];
                        self.contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height+45, 320, 295)];
                        self.contentWebView.delegate = self;
                        [self.contentWebView loadHTMLString:self.ziXunContent baseURL:[NSURL URLWithString:@"about:blank"]];
                    }
                }
                
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
        
    }else if (self.sourceViewNumber == COMEFROM_COLLECT){
        DBsqlite *db = [[DBsqlite alloc]init];
        if([db connectFav])
        {
            NSString *query = [NSString stringWithFormat:@"select * from collection where id='%@';",self.zixunId];
            self.contentInDetail = [db fetchOne:query];
            NSLog(@"self.contentInDetail%@",self.contentInDetail);
            if([self.contentInDetail objectForKey:@"title"])
            {
                //计算内容所需要的高度
                CGSize size = [[self.contentInDetail objectForKey:@"title"] sizeWithFont:[UIFont systemFontOfSize:22.0] constrainedToSize:CGSizeMake(280.0, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
                CGFloat height = size.height;
                self.contentTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, height)];
                [self.contentTitleLable setNumberOfLines:0];
                self.contentTitleLable.text = [self.contentInDetail objectForKey:@"title"];
                self.contentTitleLable.backgroundColor = [UIColor clearColor];
                [self.contentTitleLable setFont:[UIFont systemFontOfSize:22.0]];
                [self.contentTitleLable setTextColor:[UIColor whiteColor]];
                [self.headerView addSubview:self.contentTitleLable];
                //设置来源，作者，发表时间
                self.detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, height+20, 280, 20)];
                [self.detailLable setFont:[UIFont systemFontOfSize:14.0]];
                [self.detailLable setText:[NSString stringWithFormat:@"%@    %@",[self.contentInDetail objectForKey:@"author"],[self.contentInDetail objectForKey:@"create_time"]]];
                [self.detailLable setBackgroundColor:[UIColor clearColor]];
                [self.detailLable setTextColor:[UIColor whiteColor]];
                [self.headerView  addSubview:self.detailLable];
                [self.headerView setFrame:CGRectMake(0,0,320, height+45)];
                //设置分享内容
                self.shareContent = [[self.contentInDetail objectForKey:@"title"] stringByAppendingString:[self.contentInDetail objectForKey:@"weiboUrl"]];
                if([self.contentInDetail objectForKey:@"wap_content"])
                {
                    self.ziXunContent = [self.contentInDetail objectForKey:@"wap_content"];
                    self.contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height+45, 320, 295)];
                    self.contentWebView.delegate = self;
                    [self.contentWebView loadHTMLString:self.ziXunContent baseURL:[NSURL URLWithString:@"about:blank"]];
                }
            }
        }
    }else{
        DBsqlite *db = [[DBsqlite alloc]init];
        if([db connectFav])
        {
            NSString *query = [NSString stringWithFormat:@" select * from browseRecord where id='%@';",self.zixunId];
            self.contentInDetail = [db fetchOne:query];
            if([self.contentInDetail objectForKey:@"title"])
            {
                //计算内容所需要的高度
                CGSize size = [[self.contentInDetail objectForKey:@"title"] sizeWithFont:[UIFont systemFontOfSize:22.0] constrainedToSize:CGSizeMake(280.0, 1000.0f) lineBreakMode:UILineBreakModeWordWrap];
                CGFloat height = size.height;
                self.contentTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, height)];
                [self.contentTitleLable setNumberOfLines:0];
                self.contentTitleLable.text = [self.contentInDetail objectForKey:@"title"];
                self.contentTitleLable.backgroundColor = [UIColor clearColor];
                [self.contentTitleLable setFont:[UIFont systemFontOfSize:22.0]];
                [self.contentTitleLable setTextColor:[UIColor whiteColor]];
                [self.headerView addSubview:self.contentTitleLable];
                //设置来源，作者，发表时间
                self.detailLable = [[UILabel alloc]initWithFrame:CGRectMake(10, height+20, 280, 20)];
                [self.detailLable setFont:[UIFont systemFontOfSize:14.0]];
                [self.detailLable setText:[NSString stringWithFormat:@"%@    %@",[self.contentInDetail objectForKey:@"author"],[self.contentInDetail objectForKey:@"create_time"]]];
                [self.detailLable setBackgroundColor:[UIColor clearColor]];
                [self.detailLable setTextColor:[UIColor whiteColor]];
                [self.headerView  addSubview:self.detailLable];
                [self.headerView setFrame:CGRectMake(0,0,320, height+45)];
                //设置分享内容
                self.shareContent = [[self.contentInDetail objectForKey:@"title"] stringByAppendingString:[self.contentInDetail objectForKey:@"weiboUrl"]];
                if([self.contentInDetail objectForKey:@"wap_content"])
                {
                    self.ziXunContent = [self.contentInDetail objectForKey:@"wap_content"];
                    self.contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height+45, 320, 295)];
                    self.contentWebView.delegate = self;
                    [self.contentWebView loadHTMLString:self.ziXunContent baseURL:[NSURL URLWithString:@"about:blank"]];
                }
            }
        }
    }
    CGSize mianSize = [UIScreen mainScreen].bounds.size;
    //生成底部返回和分享按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, mianSize.height-65, 106.7, 45)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"ContentBack.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    //生成收藏按钮
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectButton setFrame:CGRectMake(106.7, mianSize.height-65, 106.7, 45)];
    [collectButton setBackgroundImage:[UIImage imageNamed:@"CollectContent.png"] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectContent:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(213.4, mianSize.height-65, 106.7, 45)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"ContentShare.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(contentShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectButton];
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

- (void)searchViewGo:(id)sender
{
    SearchContentViewController *searchVC = [[SearchContentViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

//相应收藏按钮事件

- (void)collectContent:(id)sender
{
    DBsqlite *db = [[DBsqlite alloc]init];
    if([db connectFav])
    {
        NSString *query1 = @"create table if not exists collection ('id','title','wap_content','create_time','weiboUrl','author','collect_time');";
        [db exec:query1];
        NSString *query = [NSString stringWithFormat:@"collection where id = '%@';",[self.contentInDetail objectForKey:@"id"]];
        NSString *resultCount = [db count:query];
        NSDate *dateNow = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval baseTime = [dateNow timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%.0f",baseTime];
        NSString *queryString;
        if([resultCount isEqualToString:@"0"])
        {
           queryString = [NSString stringWithFormat:@"INSERT INTO collection ('id','title','wap_content','create_time','weiboUrl','author','collect_time') VALUES ('%@','%@','%@','%@','%@','%@','%@');",[self.contentInDetail objectForKey:@"id"],[self.contentInDetail objectForKey:@"title"],[self.contentInDetail objectForKey:@"wap_content"],[self.contentInDetail objectForKey:@"create_time"],[self.contentInDetail objectForKey:@"weiboUrl"],[self.contentInDetail objectForKey:@"author"],timeString];
        }else{
            queryString  = [NSString stringWithFormat:@"update collection set collect_time = '%@' where id = '%@';",timeString,[self.contentInDetail objectForKey:@"id"]];
        }
        if([db exec:queryString])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示"
                                                         message:@"恭喜您，您已成功收藏该百科！"
                                                        delegate:self
                                               cancelButtonTitle:@"ok"
                                               otherButtonTitles:nil, nil];
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示"
                                                         message:@"收藏失败，请重新收藏！"
                                                        delegate:self
                                               cancelButtonTitle:@"ok"
                                               otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}


- (NSMutableDictionary *)contentInDetail
{
    if(_contentInDetail == nil)
    {
        _contentInDetail = [[NSMutableDictionary alloc]init];
    }
    return _contentInDetail;
}

@end
