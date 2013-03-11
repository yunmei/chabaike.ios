//
//  FeedBackViewController.m
//  chabaike
//
//  Created by Mac on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedBackViewController.h"
#import<SystemConfiguration/SystemConfiguration.h>
#import<netdb.h>
@implementation FeedBackViewController
@synthesize feedbackTitle;
@synthesize feedbackcontact;
@synthesize rightBarItem;
@synthesize hostReach;
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
    self.title=@"用户反馈";
    self.navigationItem.rightBarButtonItem=self.rightBarItem;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) postfeedback{
    UIAlertView *alert=[[UIAlertView alloc]init];
    if (feedbackTitle.text.length<2) {
        alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"建议标题字数不小于2个" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    if (feedbackcontact.text.length<10) {
        alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"反馈内容字数不小于10个" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
        [alert show];
        return;
    }
    NSString *connectionKind=@"";
    Boolean feedBackPost=FALSE;
    hostReach = [Reachability reachabilityWithHostName:@"www.maimaicha.cn"];
	switch ([hostReach currentReachabilityStatus]) {
		case NotReachable:
			connectionKind = @"没有网络，暂时不能进行提交意见反馈";
			break;
		case ReachableViaWiFi:
        {
            feedBackPost=TRUE;
            break;
		}
        case ReachableViaWWAN:
            feedBackPost=TRUE;
			break;
		default:
			break;
	}
    if (feedBackPost) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"2" forKey:@"type"];
        [params setObject:self.feedbackTitle.text forKey:@"title"];
        [params setObject:self.feedbackcontact.text forKey:@"content"];  
        [Utility getResultData:params];
        connectionKind=@"感谢您对我们的支持，感谢您提交意见反馈";
    }
    alert=[[UIAlertView alloc]initWithTitle:@"友情提示" 
                                    message:connectionKind 
                                   delegate:self 
                          cancelButtonTitle:@"ok" 
                          otherButtonTitles:nil,nil];
    [alert show];
     alert=nil;
    if (feedBackPost) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidUnload
{
    [self setRightBarItem:nil];
    [self setFeedbackcontact:nil];
    [self setFeedbackTitle:nil];
    [super viewDidUnload];
    
}
-(UIBarButtonItem *)rightBarItem
{
    if (rightBarItem==nil) {
        //rightBarItem=[[UIBarButtonItem alloc]initWithCustomView:self.uibutton];
        rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"提交反馈" 
                                                     style:UIBarButtonItemStyleBordered 
                                                    target:self 
                                                    action:@selector(postfeedback)];
    }
    return rightBarItem;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
