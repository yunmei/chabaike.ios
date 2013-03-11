//
//  FavViewController.h
//  chabaike
//
//  Created by Mac on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavActicleViewController.h"
#import "DBsqlite.h"
#import "baikeFavCell.h"
@class PullToRefreshTableView; 
@interface FavViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int pageNum;
    int pageNumCount;
    Boolean loadlistend;
}
@property(strong, nonatomic)PullToRefreshTableView *tableview;
@property(strong, nonatomic)NSMutableArray *favlist;
@property(strong, nonatomic)NSMutableArray *favlist_page;
@property(strong, nonatomic)UIBarButtonItem *rightBarItem;
@property(strong, nonatomic)UIButton *uibutton;
-(void)getFavBaikeDatalist;
@end
