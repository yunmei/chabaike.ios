//
//  ListViewController.m
//  chabaike
//
//  Created by bevin chen on 13-3-19.
//
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize refreshTableView;
@synthesize tableArray;
@synthesize type;
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.refreshTableView = nil;
    self.tableArray = nil;
    [super viewDidUnload];
}

- (PullToRefreshTableView *)refreshTableView
{
    if (refreshTableView == nil) {
        refreshTableView = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-20)];
        [refreshTableView setRowHeight:80.0];
        refreshTableView.delegate = self;
        refreshTableView.dataSource = self;
        refreshTableView.tag = 1;
    }
    return refreshTableView;
}
@end
