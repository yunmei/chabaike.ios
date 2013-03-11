//
//  FeedBackViewController.h
//  chabaike
//
//  Created by Mac on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Utility.h"
@interface FeedBackViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *feedbackTitle;
@property (strong, nonatomic) IBOutlet UITextView *feedbackcontact;
@property(strong,nonatomic)UIBarButtonItem *rightBarItem;
@property (strong ,nonatomic) Reachability *hostReach;
-(void)postfeedback;
@end
