//
//  SearchContentViewController.h
//  chabaike
//
//  Created by ken on 13-3-13.
//
//

#import <UIKit/UIKit.h>
#import "DBsqlite.h"
@interface SearchContentViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic)NSMutableArray *searchKeyHotList;
@property (strong, nonatomic)UITextField *searchContentFeild;
@end
