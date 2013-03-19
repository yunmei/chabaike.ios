//
//  ListViewController.m
//  chabaike
//
//  Created by bevin chen on 13-3-19.
//
//

#import "ListViewController.h"
#import "MBProgressHUD.h"
#import "NewsCell.h"

@interface ListViewController ()

@end

@implementation ListViewController
@synthesize refreshTableView;
@synthesize tableArray;
@synthesize type;
@synthesize keyword;
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
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // 搜索操作
    if (self.type == LISTVIEW_TYPE_SEARCH) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.searcListByTitle",@"method", self.keyword, @"search", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
            if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"]) {
                self.tableArray = [object objectForKey:@"data"];
                [self.refreshTableView reloadData:NO];
            }
            [HUD hide:YES];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
            [HUD hide:YES];
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc]init];
    float titleLabelWidth = 220;
    static NSString *cellIdentifier = @"listViewCell";
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    tempDictionary = [tableArray objectAtIndex:indexPath.row];
    cell.newsTitleLabel.text = [tempDictionary objectForKey:@"title"];
    [cell.contentView addSubview:cell.newsTitleLabel];
    if (![[tempDictionary objectForKey:@"wap_thumb"] isEqualToString:@""]) {
        [YMGlobal loadImage:[tempDictionary objectForKey:@"wap_thumb"] andImageView:cell.newsImageView];
        titleLabelWidth = 220;
    } else {
        [cell.newsImageView setImage:[UIImage imageNamed:@"white"]];
        titleLabelWidth = 300;
    }
    [cell.contentView addSubview:cell.newsImageView];
    CGSize labelSize = [cell.newsTitleLabel.text sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] constrainedToSize:CGSizeMake(titleLabelWidth, 40) lineBreakMode:UILineBreakModeCharacterWrap];
    [cell.newsTitleLabel setFrame:CGRectMake(5, 5, labelSize.width, labelSize.height)];
    if (cell.newsTitleLabel.frame.size.height == 20) {
        [cell.newsDescLabel setFrame:CGRectMake(5, 28, titleLabelWidth, 20)];
        cell.newsDescLabel.text = [tempDictionary objectForKey:@"description"];
    } else {
        cell.newsDescLabel.text = @"";
    }
    [cell.contentView addSubview:cell.newsDescLabel];
    cell.newsOtherLabel.text = [NSString stringWithFormat:@"%@　%@　%@", [tempDictionary objectForKey:@"source"],[tempDictionary objectForKey:@"nickname"], [tempDictionary objectForKey:@"create_time"]];
    [cell.contentView addSubview:cell.newsOtherLabel];
    return cell;
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
