//
//  NewsCell.h
//  chashequ.ios
//
//  Created by bevin chen on 13-3-7.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) UIImageView *newsImageView;
@property (strong, nonatomic) UILabel *newsTitleLabel;
@property (strong, nonatomic) UILabel *newsOtherLabel;
@property (strong, nonatomic) UILabel *newsDescLabel;
@end
