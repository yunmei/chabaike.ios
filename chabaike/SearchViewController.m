//
//  SearchViewController.m
//  chabaike
//
//  Created by Mac on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#define BUTTONHIGHT 35
#define BUTTONFONTSIZE 13.0
@implementation SearchViewController
@synthesize searchBar;
@synthesize tableview;
@synthesize uibutSearHis;
@synthesize uibutSearHot;
@synthesize uibutSearClear;
@synthesize colorNormal;
@synthesize colorSelected;
@synthesize labelSearStates;
@synthesize searchKeyList;
@synthesize searchKeyHotList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    buttonstates=1;
    if (buttonstates==1) {
        [self getSearchKeys];
    }
    else {
        [self getSearchKeysHot];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.searchBar setText:@""];
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    [self saveSearchKey:self.searchBar.text];
    [self gotoSearchList:self.searchBar.text];
    [self getSearchKeys];
    [tableview reloadData];
}
-(void) gotoSearchList:(NSString *)skeyValue
{
    SearchListViewController *detailview=[[SearchListViewController alloc]init];
    detailview.searchKey=skeyValue;
    [self.navigationController pushViewController:detailview animated:(YES)];
}
-(void) getSearchKeys
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    searchKeyList=[[NSMutableArray alloc]init];
    if([dbsqlite connectSearch])
    {
        searchKeyList=[dbsqlite fetchAll:@"select * from searchHistory;"];
        //NSLog(@"搜索记录总数为：%d",self.searchKeyList.count);
        [dbsqlite close];
    }
}
-(void) getSearchKeysHot
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    searchKeyHotList=[[NSMutableArray alloc]init];
    if([dbsqlite connectSearch])
    {
        searchKeyHotList=[dbsqlite fetchAll:@"select * from searchKeysHot;"];
        [dbsqlite close];
    }
}
-(void) saveSearchKey:(NSString*)skey;
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    if([dbsqlite connectSearch])
    {
        NSString *querysql=[NSString stringWithFormat:@" searchHistory where skey='%@';",skey];
        
        NSString *resultcount=[dbsqlite count:querysql];
        if([resultcount isEqualToString:@"0"])
        {
            querysql=[NSString stringWithFormat:@"INSERT INTO searchHistory (skey,creattime) VALUES ('%@',datetime('now','localtime'));",skey];
        }
        else
        {
            querysql=[NSString stringWithFormat:@"UPDATE searchHistory SET creattime=datetime('now', 'localtime') WHERE  skey='%@';",skey];
        }
        [dbsqlite exec:querysql];
        [dbsqlite close];
    }
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES];
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
            //[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        }
    }
    
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setText:@""];
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
}
- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setTableview:nil];
    [self setUibutSearHis:nil];
    [self setUibutSearHot:nil];
    [self setUibutSearClear:nil];
    [self setLabelSearStates:nil];
    [self setSearchKeyList:nil];
    [self setSearchKeyHotList:nil];
    [super viewDidUnload];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (buttonstates==1) {
        return searchKeyList.count+2;
    }
    else {
        return searchKeyHotList.count+1;
    }
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *cellIndetifier = @"Cell";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];        
        [cell addSubview:self.uibutSearHot];
        [cell addSubview:self.uibutSearHis];
        return cell;
    }
    else {
        chabaikeCell *cell=[[chabaikeCell alloc]init];
        if (buttonstates==1) {
            if (self.searchKeyList.count==0) {
                [cell addSubview:self.labelSearStates];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            else {
                if (self.searchKeyList.count==indexPath.row-1) {
                    cell.accessoryType=UITableViewCellAccessoryNone;
                    [cell addSubview:self.uibutSearClear];
                }
                else {
                    [cell.uiLabMsg setText:@"百科:"];
                    [cell.uiLabMsg setTextColor:[UIColor grayColor]];
                    NSMutableDictionary *result=[self.searchKeyList objectAtIndex:indexPath.row-1];
                    [cell.uiLabContact setText:[result objectForKey:@"skey"]];
                    result=nil;
                    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                }
            }
        }
        else{
            [cell.uiLabMsg setText:[NSString stringWithFormat:@"%d",indexPath.row]];
            [cell.uiLabMsg setTextColor:[UIColor redColor]];
            NSMutableDictionary *result=[self.searchKeyHotList objectAtIndex:indexPath.row-1];
            [cell.uiLabContact setText:[result objectForKey:@"hotTitle"]];
            result=nil;
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    chabaikeCell *cell=(chabaikeCell *)[tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    [tableview deselectRowAtIndexPath:[tableview indexPathForSelectedRow] animated:YES];
    if (buttonstates !=1 || self.searchKeyList.count>0) {
        [self gotoSearchList:cell.uiLabContact.text];
    }
}
-(void)hitsearchList:(id)sender
{
    buttonstates=1;
    [self getSearchKeys];
    [tableview reloadData];
}
-(void)hitsearchHot:(id)sender
{
    buttonstates=2;
    [self getSearchKeysHot];
    [tableview reloadData];
    
}
-(void)hitsearchClear:(id)sender
{
    if (buttonstates==1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"确定清空搜索记录？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil]; 
        [alert show];
        alert=nil;
    }
}
#pragma mark ---- UIAlertView Deleagate ----
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0) {
        NSString *query=[NSString stringWithFormat:@"DELETE FROM searchHistory;"];
        
        DBsqlite *dbsqlite=[[DBsqlite alloc]init];
        if ([dbsqlite connectSearch]) {
            [dbsqlite exec:query];
            [dbsqlite close];
        }
        dbsqlite=nil;
        query=nil;
		[self getSearchKeys];
        [tableview reloadData];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(UIColor *)colorNormal
{
    if (colorNormal==nil) {
        colorNormal=[[UIColor alloc]initWithWhite:240/255.0 alpha:1.0];
    }
    return colorNormal;
}
-(UIColor *)colorSelected
{
    if (colorSelected==Nil) {
        colorSelected=[[UIColor alloc]initWithWhite:200/255.0 alpha:1.0];
    }
    return colorSelected;
}
-(UIButton *)uibutSearHis
{
    if (uibutSearHis==nil) {
        
        uibutSearHis = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [uibutSearHis setFrame:CGRectMake(30, 5, 120, BUTTONHIGHT)];
        [uibutSearHis setTitle:@"搜索记录" forState:UIControlStateNormal];
        [uibutSearHis setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [uibutSearHis.titleLabel setFont:[UIFont systemFontOfSize:BUTTONFONTSIZE]];
        [uibutSearHis addTarget:self action:@selector(hitsearchList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return uibutSearHis;
}
-(UILabel *)labelSearStates
{
    if (labelSearStates==nil) {
        labelSearStates=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 320, 30)];
        [labelSearStates setFont:[UIFont systemFontOfSize:BUTTONFONTSIZE]];
        [labelSearStates setTextAlignment:UITextAlignmentCenter];
        [labelSearStates setText:@"尚未发现搜索记录"];
        [labelSearStates setBackgroundColor:[UIColor clearColor]];
    }
    return labelSearStates;
}
-(UIButton *)uibutSearClear
{
    if (uibutSearClear==nil) {
        uibutSearClear = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [uibutSearClear setFrame:CGRectMake(110, 5,100, BUTTONHIGHT)];
        [uibutSearClear setTitle:@"清空搜索记录" forState:UIControlStateNormal];
        [uibutSearClear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [uibutSearClear.titleLabel setFont:[UIFont systemFontOfSize:BUTTONFONTSIZE]];
        [uibutSearClear.titleLabel setTextAlignment:UITextAlignmentCenter];
        [uibutSearClear addTarget:self action:@selector(hitsearchClear:) forControlEvents:UIControlEventTouchUpInside];
    }
    return uibutSearClear;
}
-(UIButton *)uibutSearHot
{
    if (uibutSearHot==nil) {
        uibutSearHot = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [uibutSearHot setFrame:CGRectMake(170, 5, 120, BUTTONHIGHT)];
        [uibutSearHot setTitle:@"热门搜索" forState:UIControlStateNormal];
        [uibutSearHot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [uibutSearHot.titleLabel setFont:[UIFont systemFontOfSize:BUTTONFONTSIZE]];
        [uibutSearHot addTarget:self action:@selector(hitsearchHot:) forControlEvents:UIControlEventTouchUpInside];
    }
    return uibutSearHot;
}
@end
