//
//  baikeFavCell.m
//  chabaike
//
//  Created by Mac on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "baikeFavCell.h"

@implementation baikeFavCell

@synthesize uiLabTitel;
@synthesize uiLabTime;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 60)];
        [self setBackgroundColor:[UIColor blueColor]];
        [self addSubview:self.uiLabTitel];
        [self addSubview:self.uiLabTime];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(UILabel *)uiLabTitel
{
    if (uiLabTitel==nil) {
        uiLabTitel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 270, 30)];
        [uiLabTitel setFont:[UIFont systemFontOfSize:14.0]];
        [uiLabTitel setBackgroundColor:[UIColor clearColor]];
        [uiLabTitel setTextColor:[UIColor blackColor]];
    }
    return uiLabTitel;
}
-(UILabel *)uiLabTime
{
    if (uiLabTime==nil) {
        uiLabTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 270, 20)];
        [uiLabTime setFont:[UIFont systemFontOfSize:12.0]];
        [uiLabTime setTextAlignment:UITextAlignmentRight];
        [uiLabTime setBackgroundColor:[UIColor clearColor]];
        [uiLabTime setTextColor:[UIColor grayColor]];
    }
    return uiLabTime;
}
@end
