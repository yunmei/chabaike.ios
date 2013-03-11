//
//  AboutViewController.m
//  chabaike
//
//  Created by Mac on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"关于茶百科";
    }
    return self;
}

- (void)viewDidLoad
{
//    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
//    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
// tableView处理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 366;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize: 14.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
    [logoView setFrame:CGRectMake(70, 40, 182, 88)];
    [cell addSubview:logoView];
    
    UILabel *label = [[UILabel alloc]init];
    [label setFrame:CGRectMake(20, 160, 280, 30)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:20.0]];
    [label setText:@"买卖茶.茶百科"];
    [cell addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 190, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor grayColor]];
    [label setFont:[UIFont systemFontOfSize:16.0]];
    [label setText:@"iPhone v1.0"];
    [cell addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 270, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setText:@"Copyright©2010-2012 MaiMaiCha.cn"];
    [cell addSubview:label];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(20, 290, 280, 20)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setText:@"买卖茶 版权所有"];
    [cell addSubview:label];
    
    return cell;
}
@end
