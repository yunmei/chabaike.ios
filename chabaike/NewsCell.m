//
//  NewsCell.m
//  chashequ.ios
//
//  Created by bevin chen on 13-3-7.
//  Copyright (c) 2013年 maimaicha. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

@synthesize newsImageView;
@synthesize newsTitleLabel;
@synthesize newsOtherLabel;
@synthesize newsDescLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:247/255.0];
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)newsTitleLabel
{
    if (newsTitleLabel == nil) {
        newsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 220, 20)];
        [newsTitleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [newsTitleLabel setBackgroundColor:[UIColor clearColor]];
        newsTitleLabel.numberOfLines = 0;
        newsTitleLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    return newsTitleLabel;
}

- (UILabel *)newsOtherLabel
{
    if (newsOtherLabel == nil) {
        newsOtherLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, 300, 20)];
        [newsOtherLabel setFont:[UIFont systemFontOfSize:12.0]];
        newsOtherLabel.textColor = [UIColor grayColor];
        [newsOtherLabel setBackgroundColor:[UIColor clearColor]];
    }
    return newsOtherLabel;
}

- (UILabel *)newsDescLabel
{
    if (newsDescLabel == nil) {
        newsDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 28, 220, 20)];
        [newsDescLabel setFont:[UIFont systemFontOfSize:12.0]];
        [newsDescLabel setBackgroundColor:[UIColor clearColor]];
        newsDescLabel.textColor = [UIColor grayColor];
        newsDescLabel.numberOfLines = 0;
        newsDescLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    return newsDescLabel;
}

- (UIImageView *)newsImageView
{
    if (newsImageView == nil) {
        newsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(230, 10, 80, 60)];
    }
    return newsImageView;
}
@end
