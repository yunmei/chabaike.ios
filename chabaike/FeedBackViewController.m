//
//  FeedBackViewController.m
//  chabaike
//
//  Created by ken on 13-3-20.
//
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
@synthesize titleFeild;
@synthesize contentTextView;
@synthesize submitButton;
@synthesize tapGesture = _tapGesture;
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
    
    // 增加右划手势返回
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backView:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    [headerView setImage:[UIImage imageNamed:@"SearchHeader.png"]];
    [headerView setUserInteractionEnabled:YES];
    //返回小箭头
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(15, 18, 15, 20)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Search_backBtn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    //lable
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 15, 80, 30)];
    [titleLable setText:@"茶百科"];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setFont:[UIFont systemFontOfSize:26.0]];
    [titleLable setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0]];
    //右部button
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton setFrame:CGRectMake(270, 10, 30, 30)];
    [rightTopButton setBackgroundImage:[UIImage imageNamed:@"RightTopButton.png"] forState:UIControlStateNormal];
    [headerView addSubview:rightTopButton];
    [headerView addSubview:titleLable];
    [headerView addSubview:backButton];
    [self.view addSubview:headerView];
    [self.submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setTitleFeild:nil];
    [self setContentTextView:nil];
    [self setSubmitButton:nil];
    [super viewDidUnload];
}

- (void) submit:(id)sender
{
    if([self.contentTextView.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"不要提交空内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    UIAlertView *alert=[[UIAlertView alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"2" forKey:@"type"];
        [params setObject:self.titleFeild.text forKey:@"title"];
        [params setObject:self.contentTextView.text forKey:@"content"];
        [FeedBackViewController getResultData:params];
        NSString *connectionKind=@"感谢您对我们的支持，感谢您提交意见反馈";
    alert=[[UIAlertView alloc]initWithTitle:@"友情提示"
                                    message:connectionKind
                                   delegate:self
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil,nil];
    self.titleFeild.text = @"";
    self.contentTextView.text = @"";
    [alert show];
}

+(NSData *)getResultData:(NSMutableDictionary *)params
{
    NSString *postUrl=[FeedBackViewController createPostUrl:params];
    //NSLog(@"postUrl:%@", postUrl);
    NSError *error;
    NSURLResponse *theResponse;
    NSString *requestUrl = [NSString stringWithFormat:@"%@?apikey=%@&format=json&method=system.feedback", @"http://sns.maimaicha.com/api",@"b4f4ee31a8b9acc866ef2afb754c33e6"];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody:[postUrl dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    return [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&error];
    
    
}

+(NSString *)createPostUrl:(NSMutableDictionary *)params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:self.tapGesture];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.view removeGestureRecognizer:self.tapGesture];
}

- (UITapGestureRecognizer *)tapGesture
{
    if(_tapGesture == nil)
    {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
    }
    return _tapGesture;
}

- (void)hideKeyBoard:(id)sender
{
    [self.contentTextView resignFirstResponder];
    [self.titleFeild resignFirstResponder];
}

@end
