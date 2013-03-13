//
//  SearchContentViewController.m
//  chabaike
//
//  Created by ken on 13-3-13.
//
//

#import "SearchContentViewController.h"

@interface SearchContentViewController ()

@end

@implementation SearchContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *searchBackImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, 280, 40)];
    [searchBackImageView setImage:[UIImage imageNamed:@"search.png"]];
    [searchBackImageView setUserInteractionEnabled:YES];
    UITextField *searchTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(30, 10, 250, 20)];
    //[searchTextFeild setBorderStyle:UITextBorderStyleLine];
    [searchBackImageView addSubview:searchTextFeild];
    [self.view addSubview:searchBackImageView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
