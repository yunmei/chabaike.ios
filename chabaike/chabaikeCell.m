//
//  chabaikeCell.m
//  chabaike
//
//  Created by Mac on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "chabaikeCell.h"

@implementation chabaikeCell
@synthesize uiLabMsg;
@synthesize uiLabContact;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setFrame:CGRectMake(0, 0, 320, 44)];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.uiLabMsg];
        [self addSubview:self.uiLabContact];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)uiLabMsg
{
    if (uiLabMsg==nil) {
        uiLabMsg=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
        [uiLabMsg setFont:[UIFont systemFontOfSize:14.0]];
        [uiLabMsg setBackgroundColor:[UIColor clearColor]];
        [uiLabMsg setTextAlignment:UITextAlignmentCenter];
    }
    return uiLabMsg;
}
-(UILabel *)uiLabContact
{
    if (uiLabContact==nil) {
        uiLabContact=[[UILabel alloc]initWithFrame:CGRectMake(65, 10, 200, 30)];
        [uiLabContact setFont:[UIFont systemFontOfSize:14.0]];
         [uiLabContact setBackgroundColor:[UIColor clearColor]];
    }
    return uiLabContact;
}
@end
