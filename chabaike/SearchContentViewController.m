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
@synthesize searchKeyHotList;
@synthesize searchContentFeild;

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
    [self.view setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
    // Do any additional setup after loading the view from its nib.
    //生成顶部bar
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    [headerView setImage:[UIImage imageNamed:@"SearchHeader.png"]];
    [headerView setUserInteractionEnabled:YES];
    //返回小箭头
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(15, 18, 15, 20)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Search_backBtn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    //lable
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 15, 80, 30)];
    [titleLable setText:@"茶百科"];
    [titleLable setBackgroundColor:[UIColor clearColor]];
    [titleLable setFont:[UIFont systemFontOfSize:26.0]];
    [titleLable setTextColor:[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1.0]];
    //右部button
    UIButton *rightTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTopButton setFrame:CGRectMake(260, 10, 30, 30)];
    [rightTopButton setBackgroundImage:[UIImage imageNamed:@"RightTopButton.png"] forState:UIControlStateNormal];
    [headerView addSubview:rightTopButton];
    [headerView addSubview:titleLable];
    [headerView addSubview:backButton];
    [self.view addSubview:headerView];
    //搜索框
    UIImageView *searchImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 220, 35)];
    [searchImageView setImage:[UIImage imageNamed:@"SearchBorder.png"]];
    [searchImageView setUserInteractionEnabled:YES];
    self.searchContentFeild = [[UITextField alloc]initWithFrame:CGRectMake(32, 1, 188, 33)];
    self.searchContentFeild.delegate = self;
    //[searchContentFeild setBorderStyle:UITextBorderStyleLine];
    self.searchContentFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [searchImageView addSubview:self.searchContentFeild];
    UIButton *goSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goSearchButton setBackgroundImage:[UIImage imageNamed:@"GoSearch.png"] forState:UIControlStateNormal];
    [goSearchButton setFrame:CGRectMake(245, 100, 70, 35)];
    [goSearchButton addTarget:self action:@selector(goSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goSearchButton];
    [self.view addSubview:searchImageView];
    //收藏夹
    UIImageView *scImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,180, 300, 15)];
    [scImageView setImage:[UIImage imageNamed:@"Shoucangjia.png"]];
    UILabel *scLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 15)];
    [scLable setText:@"收藏夹"];
    [scLable setTextColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0]];
    [scLable setBackgroundColor:[UIColor clearColor]];
    [scLable setFont:[UIFont systemFontOfSize:13.0]];
    [scImageView addSubview:scLable];
    [self.view addSubview:scImageView];
        //收藏夹
    UIButton *scButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scButton setFrame:CGRectMake(20, 210, 320, 30)];
    [scButton setTitle:@"收藏夹" forState:UIControlStateNormal];
    [scButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [scButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:scButton];
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 250, 280, 1)];
    [lineView setImage:[UIImage imageNamed:@"Onepx.png"]];
    [self.view addSubview:lineView];
    UIButton *jlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [jlButton setFrame:CGRectMake(20, 260, 320, 30)];
    //jlButton setImage:[UIImage image] forState:<#(UIControlState)#>
    [jlButton setTitle:@"访问记录" forState:UIControlStateNormal];
    [jlButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [jlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:jlButton];
    //关于我们
    UIImageView *gyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 315, 300, 15)];
    [gyImageView setImage:[UIImage imageNamed:@"Guanyu.png"]];
    UILabel *gyLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 15)];
    [gyLable setText:@"关于客户端"];
    [gyLable setTextColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0]];
    [gyLable setBackgroundColor:[UIColor clearColor]];
    [gyLable setFont:[UIFont systemFontOfSize:13.0]];
    [gyImageView addSubview:gyLable];
    UIButton *bqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bqButton setFrame:CGRectMake(20, 345, 320, 30)];
    [bqButton setTitle:@"版权信息" forState:UIControlStateNormal];
    [bqButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:bqButton];
    UIImageView *llineView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 385, 280, 1)];
    [llineView setImage:[UIImage imageNamed:@"Onepx.png"]];
    [self.view addSubview:llineView];
    UIButton *yjButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [yjButton setFrame:CGRectMake(20, 395, 320, 30)];
    [yjButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    [yjButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [yjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yjButton addTarget:self action:@selector(goSurgest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yjButton];

    [self.view addSubview:gyImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backView:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取热门搜索的词条
-(void) getSearchKeysHot
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    self.searchKeyHotList=[[NSMutableArray alloc]init];
    if([dbsqlite connectSearch])
    {
        self.searchKeyHotList=[dbsqlite fetchAll:@"select * from searchKeysHot;"];
        [dbsqlite close];
    }
}

//将搜索的内容加入热门搜索的数据库
-(void) saveSearchKey:(NSString*)skey;
{
    DBsqlite *dbsqlite=[[DBsqlite alloc]init];
    if([dbsqlite connectSearch])
    {
        NSString *querysql=[NSString stringWithFormat:@" searchHistory where skey='%@';",skey];
        
        NSString *resultcount=[dbsqlite count:querysql];
        if([resultcount isEqualToString:@"0"])
        {
            querysql=[NSString stringWithFormat:@"INSERT INTO searchHistory (skey,creattime) VALUES ('%@',datetime('now','localtime'));",skey];
        }
        else
        {
            querysql=[NSString stringWithFormat:@"UPDATE searchHistory SET creattime=datetime('now', 'localtime') WHERE  skey='%@';",skey];
        }
        [dbsqlite exec:querysql];
        [dbsqlite close];
    }
    
}

//点击搜索按钮

- (void)goSearch:(UIButton *)sender
{
    
    NSLog(@"search");
}

- (void)tapOnScreen
{
    [self.searchContentFeild resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchContentFeild resignFirstResponder];
    return YES;
}


@end
