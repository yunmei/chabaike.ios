//
//  ListViewController.h
//  chabaike
//
//  Created by bevin chen on 13-3-19.
//
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "SBJson.h"
#import "ZixunContentViewController.h"
#import "PullToRefreshTableView.h"

#define LISTVIEW_TYPE_SEARCH    0     // 类型：搜索
#define LISTVIEW_TYPE_FAVORITE  1     // 类型：收藏

@interface ListViewController : UIViewController<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PullToRefreshTableView *refreshTableView;
@property (strong, nonatomic) NSMutableArray *tableArray;
@property (nonatomic) int type;

@end