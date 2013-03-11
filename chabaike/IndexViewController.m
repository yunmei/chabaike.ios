//
//  IndexViewController.m
//  chabaike
//
//  Created by dzs on 12-4-23.
//  Copyright (c) 2012年 maimaicha. All rights reserved.
//

#import "IndexViewController.h"
#import "PullToRefreshTableView.h"

@implementation IndexViewController
@synthesize tableview;
@synthesize baikelist;
@synthesize baikelist_page;
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
    pageNumCount=10;
    pageNum=0;
    loadlistend=NO;
    baikelist_page=[[NSMutableArray alloc]init];
    tableview=[[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 366)];
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [tableview setRowHeight:50.0];
    
    [self.view addSubview:tableview];
    [self getBaikeDatalist];
    [self updateTableView];
    [super viewDidLoad];
    
}
#pragma mark- tableview pull


- (void)updateThread:(NSString *)returnKey{
    sleep(2);
   @autoreleasepool {
    switch ([returnKey intValue]) {
        case k_RETURN_LOADMORE:
            pageNum=pageNum+1;
            [self getBaikeDatalist];
            break;
            
        default:
            break;
    }
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
   }
}
- (void)updateTableView{
    if ([self.baikelist_page count] < 10 ||loadlistend) {
        [tableview reloadData:NO];
     } else {
        [tableview reloadData:YES];
     }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [tableview tableViewDidDragging];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [tableview tableViewDidEndDragging]; 
    //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
    }
   
}

-(void)getBaikeDatalist
{
    baikelist = [[NSMutableArray alloc]init];
    DBsqlite *dbslqite = [[DBsqlite alloc]init];
    if ([dbslqite connect]) {
        NSString *query=[NSString stringWithFormat:@"SELECT id,title FROM app_baike order by id desc limit %d,%d;",pageNum*pageNumCount,pageNumCount];
        self.baikelist=[dbslqite fetchAll:query];
        //NSLog(@"self.baikelist count is %d",self.baikelist.count);
        if (self.baikelist.count < 10) {
            loadlistend=YES;
        }
        if (self.baikelist.count>0) {
         for(id i in baikelist) {
             [self.baikelist_page addObject:i];
         }
        }
    } 
    [dbslqite close];
    baikelist=nil;
}
- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setBaikelist:nil];
    [self setBaikelist_page:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return baikelist_page.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }
    NSMutableDictionary *result=[self.baikelist_page objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text=[NSString stringWithFormat:@"%d  %@",indexPath.row+1,[result objectForKey:@"title"]];
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    result=nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableview deselectRowAtIndexPath:[tableview indexPathForSelectedRow] animated:YES];
    
    NSMutableDictionary *result=[self.baikelist_page objectAtIndex:indexPath.row];
    ArticleViewController *detailview=[[ArticleViewController alloc]init];
    
    detailview.articlePassID=[result objectForKey:@"id"];
    
   
    [self.navigationController pushViewController:detailview animated:(YES)];
    
}
@end
