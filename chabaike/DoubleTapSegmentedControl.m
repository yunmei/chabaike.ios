//
//  DoubleTapSegmentedControl.m

//  Created by dzs on 12-5-8.
//  Copyright 2012年 maimaicha All rights reserved.

#import "DoubleTapSegmentedControl.h"


@implementation DoubleTapSegmentedControl
@synthesize delegate;

// Catch touches and trigger the delegate
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	if (self.delegate) [self.delegate performSegmentAction:self];
}

@end
