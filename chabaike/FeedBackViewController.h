//
//  FeedBackViewController.h
//  chabaike
//
//  Created by ken on 13-3-20.
//
//

#import <UIKit/UIKit.h>
@interface FeedBackViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *titleFeild;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@end
