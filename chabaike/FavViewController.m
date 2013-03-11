//
//  FavViewController.m
//  chabaike
//
//  Created by Mac on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FavViewController.h"
#import "PullToRefreshTableView.h"
@implementation FavViewController
@synthesize rightBarItem;
@synthesize tableview;
@synthesize favlist;
@synthesize favlist_page;
@synthesize uibutton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    pageNumCount=10;
    pageNum=0;
    loadlistend=NO;
    favlist_page=[[NSMutableArray alloc]init];
    [self getFavBaikeDatalist];
    [self updateTableView];
    [self.tableview reloadData];
}
- (void) favEditBaike{
	[tableview setEditing:!tableview.editing animated:YES];
	if(tableview.editing)
    {	
        self.navigationItem.rightBarButtonItem.title=@"完成";
        //[self.uibutton setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {	
        self.navigationItem.rightBarButtonItem.title=@"编辑";
        //[self.uibutton setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    
    self.navigationItem.rightBarButtonItem=self.rightBarItem;
    pageNumCount=10;
    pageNum=0;
    loadlistend=NO;
    favlist_page=[[NSMutableArray alloc]init];
    tableview=[[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 366)];
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [tableview setRowHeight:60.0];
    [self.view addSubview:tableview];
    [self getFavBaikeDatalist];
    [self updateTableView];    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)updateThread:(NSString *)returnKey{
    sleep(2);
    @autoreleasepool {
        switch ([returnKey intValue]) {
            case k_RETURN_LOADMORE:
                pageNum=pageNum+1;
                [self getFavBaikeDatalist];
                break;
                
            default:
                break;
        }
        [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
    }
}
- (void)updateTableView{
    if ([self.favlist_page count] < 10 ||loadlistend) {
        [tableview tablewsetState:YES];
        //[tableview reloadData:NO];
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

-(void)getFavBaikeDatalist
{
    favlist = [[NSMutableArray alloc]init];
    DBsqlite *dbslqite = [[DBsqlite alloc]init];
    if ([dbslqite connectFav]) {
        NSString *query=[NSString stringWithFormat:@"SELECT favid,title,fav_time FROM app_fav order by fav_time desc limit %d,%d;",pageNum*pageNumCount,pageNumCount];
        self.favlist=[dbslqite fetchAll:query];
        //NSLog(@"self.baikelist count is %d",self.favlist.count);
        if (self.favlist.count < 10) {
            loadlistend=YES;
        }
        if (self.favlist.count>0) {
            for(id i in favlist) {
                [self.favlist_page addObject:i];
            }
        }
    } 
    [dbslqite close];
    favlist=nil;
}
- (void)viewDidUnload
{
    [self setTableview:nil];
    [self setFavlist:nil];
    [self setFavlist_page:nil];
    [super viewDidUnload];
    [self setRightBarItem:nil];
    [self setUibutton:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return favlist_page.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    baikeFavCell *favcell=[[baikeFavCell alloc]init];
    NSMutableDictionary *result=[self.favlist_page objectAtIndex:indexPath.row];
    favcell.uiLabTime.text=[Utility setTimeInt:[[result objectForKey:@"fav_time"] intValue] setTimeFormat:@"yyyy-MM-dd" setTimeZome:nil];
    favcell.uiLabTitel.text=[result objectForKey:@"title"];
    result=nil;
    favcell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return favcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableview deselectRowAtIndexPath:[tableview indexPathForSelectedRow] animated:YES];
    
    NSMutableDictionary *result=[self.favlist_page objectAtIndex:indexPath.row];
    FavActicleViewController *detailview=[[FavActicleViewController alloc]init];
    
    detailview.favPassID=[result objectForKey:@"favid"];
    
    [self.navigationController pushViewController:detailview animated:(YES)];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{      
    return UITableViewCellEditingStyleDelete;
}
//支持记录的移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//自定义删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger row=[indexPath row];
    NSMutableDictionary *result=[self.favlist_page objectAtIndex:row];
    NSString *query=[NSString stringWithFormat:@"DELETE FROM app_fav WHERE favid =%@;",[result objectForKey:@"favid"]];
    
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    if ([dbsqlite connectFav]) {
        [dbsqlite exec:query];
        [dbsqlite close];
    }
    [self.favlist_page removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    dbsqlite=nil;
    query=nil;
    result=nil;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSUInteger fromrow=[sourceIndexPath row];
    NSUInteger torow=[destinationIndexPath row];
    id object=[favlist_page objectAtIndex:fromrow];
    [favlist_page removeObjectAtIndex:fromrow];
    [favlist_page insertObject:object atIndex:torow];
}
-(UIBarButtonItem *)rightBarItem
{
    if (rightBarItem==nil) {
      //rightBarItem=[[UIBarButtonItem alloc]initWithCustomView:self.uibutton];
        rightBarItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" 
                                                     style:UIBarButtonItemStyleBordered 
                                                    target:self 
                                                    action:@selector(favEditBaike)];
    }
    return rightBarItem;
}
-(UIButton *)uibutton
{
    if (uibutton==nil) {
        uibutton=[UIButton buttonWithType:UIButtonTypeCustom];
        uibutton.frame=CGRectMake(270, 0, 52, 30);
        [uibutton addTarget:self action:@selector(favEditBaike) forControlEvents:UIControlEventTouchUpInside];
        if(tableview.editing)
        {	
            [uibutton setTitle:@"完成" forState:UIControlStateNormal];
        }
        else
        {	[uibutton setTitle:@"编辑" forState:UIControlStateNormal];
        }
        [uibutton.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [uibutton setBackgroundImage:[UIImage imageNamed:@"buttonback.png"] forState:UIControlStateNormal];
    }
    
    return  uibutton;
}
@end
