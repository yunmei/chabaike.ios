//
//  CollectCell.m
//  chabaike
//
//  Created by ken on 13-3-20.
//
//

#import "CollectCell.h"

@implementation CollectCell
@synthesize newsTitleLabel;
@synthesize newsOtherLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        newsOtherLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 300, 20)];
        [newsOtherLabel setFont:[UIFont systemFontOfSize:12.0]];
        newsOtherLabel.textColor = [UIColor grayColor];
        [newsOtherLabel setBackgroundColor:[UIColor clearColor]];
    }
    return newsOtherLabel;
}
@end
