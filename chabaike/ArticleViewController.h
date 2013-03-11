//
//  ArticleViewController.h
//  chabaike
//
//  Created by Mac on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "Utility.h"
#import "WebViewController.h"
#import "ArticleModel.h"

@interface ArticleViewController : UIViewController<UITableViewDelegate,UITableViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic) NSString *articlePassID;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) ArticleModel *articleModel;
-(void)getBaikeDatalist;
-(void)favBaike:(id)sender;
@end
