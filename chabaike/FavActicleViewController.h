//
//  FavActicleViewController.h
//  chabaike
//
//  Created by Mac on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "Utility.h"
#import "WebViewController.h"
#import "FavModel.h"
@interface FavActicleViewController : UIViewController<UITableViewDelegate,UITableViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic) NSString *favPassID;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FavModel *favModel;
-(void)getBaikeDatalist;

@end
