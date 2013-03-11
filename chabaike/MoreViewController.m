//
//  MoreViewController.m
//  chabaike
//
//  Created by Mac on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"

@implementation MoreViewController
@synthesize tableview;

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
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 30)];
    if (indexPath.section==0) {
        textLabel.text=@"去给茶百科打个分，评价一把";
        [imageView setImage:[UIImage imageNamed:@"main_menu_good.png"]];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    else {
        if (indexPath.section==1) {
            textLabel.text=@"软件升级";
            [imageView setImage:[UIImage imageNamed:@"main_menu_gxing.png"]];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            if(indexPath.section==2){
                textLabel.text=@"意见反馈";
                [imageView setImage:[UIImage imageNamed:@"main_menu_fankui.png"]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else {
                if (indexPath.section==3) {
                    textLabel.text=@"关于茶百科";
                    [imageView setImage:[UIImage imageNamed:@"main_menu_about.png"]];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                else {
                    textLabel.text=@"客服电话：0531-83171746";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [imageView setImage:[UIImage imageNamed:@"main_menu_feedback.png"]];
                }
            }
        }
    }
    [textLabel setBackgroundColor:[UIColor clearColor]];
    textLabel.font=[UIFont systemFontOfSize:14.0];
    [cell addSubview:imageView];
    [cell addSubview:textLabel];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSString *str = [NSString stringWithFormat: 
                             @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", 
                             SERVICEAPPID];  
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//            WebViewController *webViewController = [[WebViewController alloc]init];
//            webViewController.openUrl = [NSURL URLWithString:str];
//            webViewController.showTitle = @"撰写评论";
//            UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:webViewController];
//            [self presentModalViewController:navController animated:YES];
            break;
        }  
        case 1:
        {
            if(indexPath.row == 0) {
                [MobClick checkUpdate];
            }
            break;
        }
        case 2:
        {
            if(indexPath.row == 0) {
                //[UMFeedback showFeedback:self withAppkey:@"4fab36cf527015375d000049"];
                FeedBackViewController *feedbackview=[[FeedBackViewController alloc]init];
                [self.navigationController pushViewController:feedbackview animated:YES];
            }
            break;
        }
        case 3:
        {
            if(indexPath.row == 0) {
                AboutViewController *aboutview=[[AboutViewController alloc]init];
                [self.navigationController pushViewController:aboutview animated:YES];
            }
            break;
        }
        case 4:
        {
            if(indexPath.row == 0) {
                if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", SERVICEPHONE]]];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持通话功能" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }
            break;
        }
        default:
            break;
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
