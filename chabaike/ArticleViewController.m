//
//  ArticleViewController.m
//  chabaike
//
//  Created by Mac on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleViewController.h"

@implementation ArticleViewController
@synthesize tableview;
@synthesize articleModel;
@synthesize articlePassID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)favBaike:(id)sender
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    if([dbsqlite connectFav])
    {
        NSString *querysql=[NSString stringWithFormat:@" app_fav where title='%@';",self.articleModel.articlTitle];
        
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
        
        NSString *resultcount=[dbsqlite count:querysql];
        if([resultcount isEqualToString:@"0"])
        {
            querysql=[NSString stringWithFormat:@"INSERT INTO app_fav (title,content,fav_time) VALUES ('%@','%@','%@');",articleModel.articlTitle,articleModel.articlContact,timeString];
        }
        else
        {
            querysql=[NSString stringWithFormat:@"UPDATE app_fav SET fav_time='%@' WHERE  title='%@';",timeString,articleModel.articlTitle];
        }
        NSLog(@"query %@",querysql);
        [dbsqlite exec:querysql];
        [dbsqlite close];
        querysql=nil;
        resultcount=nil;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" 
                                                     message:@"恭喜您，您已成功收藏该百科！" 
                                                    delegate:self 
                                           cancelButtonTitle:@"ok" 
                                           otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
    }
    dbsqlite=nil;
}
-(void)createBackButton
{
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStyleBordered target:self action:@selector(favBaike:)];
    self.navigationItem.rightBarButtonItem=rightBarItem;
}
- (void)viewDidLoad
{  
    [self createBackButton]; 
    [self getBaikeDatalist];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)getBaikeDatalist
{
    articleModel=[[ArticleModel alloc]init];
    DBsqlite *dbslqite = [[DBsqlite alloc]init];
    if ([dbslqite connect]) {
        NSString *query=[NSString stringWithFormat:@"SELECT id,title,create_time,content FROM app_baike where id = \"%@\";",articlePassID];
        NSMutableDictionary *result=[dbslqite  fetchOne:query];
        if([[result objectForKey:@"id"]isEqual:articlePassID])
        {
            articleModel.articlTitle=[result objectForKey:@"title"];
            articleModel.articlTime=[Utility setTimeInt:[[result objectForKey:@"create_time"] intValue] setTimeFormat:@"yyyy-MM-dd" setTimeZome:nil];
            articleModel.articlContact=[result objectForKey:@"content"];
            self.title=articleModel.articlTitle;
        }
        result=nil;
    } 
    [dbslqite close];
    dbslqite=nil;

}
- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setArticleModel:nil];
    [self setArticlePassID:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// tableView处理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 一共分为两部分
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 366;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(5, 0, 310, 366)];
        webView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
        webView.delegate = self;
    self.articleModel.articlContact=[NSString stringWithFormat:@"%@\n%@",self.articleModel.articlContact,self.articleModel.articlTime];
        [webView loadHTMLString:self.articleModel.articlContact baseURL:nil];
        [cell addSubview:webView];
    return cell;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {

        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.openUrl = request.URL;
        webViewController.showTitle = self.articleModel.articlTitle;
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:webViewController];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
    
    return YES;
}
@end
