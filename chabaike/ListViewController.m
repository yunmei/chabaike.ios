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
    [self.view addSubview:self.refreshTableView];
    
    // 增加左划手势进入searchView
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backView:)];
    [gestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:gestureRecognizer];

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
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setFont:[UIFont systemFontOfSize:26.0]];
    [titleLable setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0]];
    if (self.type == LISTVIEW_TYPE_SEARCH) {
        [titleLable setText:[NSString stringWithFormat:@"\"%@\"%@", self.keyword, @"的搜索"]];
        [titleLable setFont:[UIFont systemFontOfSize:14.0]];
    }else if (self.type == LISTVIEW_TYPE_FAVORITE){
        [titleLable setText:@"我的收藏"];
        [titleLable setFont:[UIFont systemFontOfSize:14.0]];
    }else{
        [titleLable setText:@"我的浏览记录"];
        [titleLable setFont:[UIFont systemFontOfSize:14.0]];
    }
    //右部button
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton setFrame:CGRectMake(260, 10, 30, 30)];
    [rightTopButton setBackgroundImage:[UIImage imageNamed:@"RightTopButton.png"] forState:UIControlStateNormal];
    [headerView addSubview:rightTopButton];
    [headerView addSubview:titleLable];
    [headerView addSubview:backButton];
    [self.view addSubview:headerView];
    // 搜索操作
    if (self.type == LISTVIEW_TYPE_SEARCH) {
          MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.searcListByTitle",@"method", self.keyword, @"search", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
            if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"]) {
                self.tableArray = [object objectForKey:@"data"];
                if ([self.tableArray count] < 10) {
                    [self.refreshTableView reloadData:NO];
                } else {
                    [self.refreshTableView reloadData:YES];
                }
            }
            [HUD hide:YES];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
            [HUD hide:YES];
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }else if (self.type == LISTVIEW_TYPE_FAVORITE){
        DBsqlite *db = [[DBsqlite alloc]init];
        if([db connectFav])
        {
           self.tableArray = [db fetchAll:@"select * from collection"];
            NSLog(@"self.tableArray%@",self.tableArray);
        }
    }else{
        DBsqlite *db = [[DBsqlite alloc]init];
        if([db connectFav])
        {
            self.tableArray = [db fetchAll:@"select * from browseRecord"];
        }
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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int countPage = 0;
    if (self.type == LISTVIEW_TYPE_SEARCH) {
        int state = [self.refreshTableView tableViewDidEndDragging];
        countPage = (int)ceil([tableArray count]/10);
        if (state == k_RETURN_LOADMORE) {
            //self.currentPage++;
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"news.searcListByTitle",@"method", self.keyword, @"search", nil];
            [params setObject:[NSString stringWithFormat:@"%d", (countPage+1)] forKey:@"page"];
            MKNetworkOperation *op = [YMGlobal getOperation:params];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
                if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"]) {
                    tempArray = [object objectForKey:@"data"];
                    for (id o in tempArray) {
                        [self.tableArray addObject:o];
                    }
                    if ([tempArray count] < 10) {
                        [refreshTableView reloadData:NO];
                    } else {
                        [refreshTableView reloadData:YES];
                    }
                }
                [HUD hide:YES];
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"%@",error);
                [HUD hide:YES];
            }];
            [ApplicationDelegate.appEngine enqueueOperation:op];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type == LISTVIEW_TYPE_SEARCH)
    {
        
    }
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

- (void)backView:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (PullToRefreshTableView *)refreshTableView
{
    if (refreshTableView == nil) {
        refreshTableView = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 58, 320, [UIScreen mainScreen].bounds.size.height-78)];
        [refreshTableView setRowHeight:80.0];
        refreshTableView.delegate = self;
        refreshTableView.dataSource = self;
        refreshTableView.tag = 1;
        [refreshTableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]];
    }
    return refreshTableView;
}
@end
