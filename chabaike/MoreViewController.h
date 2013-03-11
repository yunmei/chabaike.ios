//
//  MoreViewController.h
//  chabaike
//
//  Created by dzs on 12-5-9.
//  Copyright (c) 2012年 MAIMAICHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "Constants.h"
#import "FeedBackViewController.h"

@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
