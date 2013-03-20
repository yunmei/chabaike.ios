//
//  AboutViewController.m
//  chabaike
//
//  Created by bevin chen on 13-3-20.
//
//

#import "AboutViewController.h"
#import "Constants.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    // 增加右划手势返回
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backView:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    // Do any additional setup after loading the view from its nib.
    //生成顶部bar
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
    [titleLable setText:@"版权信息"];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setFont:[UIFont systemFontOfSize:20.0]];
    [titleLable setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0]];
    //右部button
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton setFrame:CGRectMake(270, 10, 30, 30)];
    [rightTopButton setBackgroundImage:[UIImage imageNamed:@"RightTopButton.png"] forState:UIControlStateNormal];
    [headerView addSubview:rightTopButton];
    [headerView addSubview:titleLable];
    [headerView addSubview:backButton];
    [self.view addSubview:headerView];
    
    // 关于我们内容 
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    [logoView setFrame:CGRectMake(70, 100, 182, 88)];
    [self.view addSubview:logoView];
    
    UILabel *label = [[UILabel alloc]init];
    [label setFrame:CGRectMake(20, 220, 280, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:20.0]];
    [label setText:@"买卖茶.茶百科"];
    [self.view addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:16.0]];
    [label setText:[NSString stringWithFormat:@"%@%@", @"Version ", SYS_VERSION ]];
    [self.view addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 330, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setText:@"Copyright©2010-2013 MaiMaiCha.cn"];
    [self.view addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 350, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setText:@"买卖茶 版权所有"];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backView:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
