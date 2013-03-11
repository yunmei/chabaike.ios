//
//  FavActicleViewController.m
//  chabaike
//
//  Created by Mac on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FavActicleViewController.h"
@implementation FavActicleViewController

@synthesize tableview;
@synthesize favModel;
@synthesize favPassID;
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
    [self getBaikeDatalist];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)getBaikeDatalist
{
    favModel=[[FavModel alloc]init];
    DBsqlite *dbslqite = [[DBsqlite alloc]init];
    if ([dbslqite connectFav]) {
        NSString *query=[NSString stringWithFormat:@"SELECT favid,title,fav_time,content FROM app_fav where favid = \"%@\";",favPassID];
        NSMutableDictionary *result=[dbslqite  fetchOne:query];
        if([[result objectForKey:@"favid"]isEqual:favPassID])
        {
            favModel.title=[result objectForKey:@"title"];
            favModel.fav_time=[Utility setTimeInt:[[result objectForKey:@"fav_time"] intValue] setTimeFormat:@"yyyy-MM-dd" setTimeZome:nil];
            favModel.content=[result objectForKey:@"content"];
            self.title=favModel.title;
        }
        result=nil;
    } 
    [dbslqite close];
    dbslqite=nil;
    
}
- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setFavModel:nil];
    [self setFavPassID:nil];
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
- (float)heightForText:(NSString *)value width:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    return sizeToFit.height;
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
    //float textheigh=[self heightForText:self.favModel.title width:310];
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    self.favModel.content=[NSString stringWithFormat:@"%@\n%@",self.favModel.content,self.favModel.fav_time];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(5, 0, 310, 366)];
    webView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    webView.delegate = self;
    [webView loadHTMLString:self.favModel.content baseURL:nil];
    [cell addSubview:webView];
    return cell;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        WebViewController *webViewController = [[WebViewController alloc]init];
        webViewController.openUrl = request.URL;
        webViewController.showTitle = self.favModel.title;
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:webViewController];
        [self presentModalViewController:navController animated:YES];
        return NO;
    }
    
    return YES;
}
@end

