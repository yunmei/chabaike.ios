//
//  IndexViewController.h
//  chabaike
//
//  Created by Mac on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "ArticleViewController.h"
@class PullToRefreshTableView; 

@interface IndexViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{    
    int pageNum;
    int pageNumCount;
    Boolean loadlistend;
}
@property(strong,nonatomic)PullToRefreshTableView *tableview;
@property(strong,nonatomic)NSMutableArray *baikelist;
@property(strong,nonatomic)NSMutableArray *baikelist_page;
-(void)getBaikeDatalist;
@end
