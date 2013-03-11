//
//  SearchViewController.h
//  chabaike
//
//  Created by Mac on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "chabaikeCell.h"
#import "SearchListViewController.h"

@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int buttonstates;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) UIButton *uibutSearHis;
@property (strong, nonatomic) UIButton *uibutSearHot;
@property (strong, nonatomic) UIButton *uibutSearClear;
@property (strong, nonatomic) UIColor *colorSelected;
@property (strong, nonatomic) UIColor *colorNormal;
@property (strong, nonatomic) UILabel *labelSearStates;
@property (strong, nonatomic) NSMutableArray *searchKeyList;
@property (strong, nonatomic) NSMutableArray *searchKeyHotList;

-(void) saveSearchKey:(NSString*)skey;
-(void) getSearchKeys;
-(void) getSearchKeysHot;
-(void) gotoSearchList:(NSString *)skeyValue;
@end
