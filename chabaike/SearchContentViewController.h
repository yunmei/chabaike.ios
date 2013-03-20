//
//  SearchContentViewController.h
//  chabaike
//
//  Created by ken on 13-3-13.
//
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
#import "FeedBackViewController.h"
@interface SearchContentViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic)NSMutableArray *searchKeyHotList;
@property (strong, nonatomic)UITextField *searchContentFeild;
@property (strong, nonatomic)NSMutableArray *hotButtonStringArrray;
@end
