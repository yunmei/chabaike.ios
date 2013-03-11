//
//  DoubleTapSegmentedControlDelegate.h
//  chabaike
//
//  Created by dzs on 11-11-23.
//  Copyright 2011年 maimaicha. All rights reserved.
//

@class DoubleTapSegmentedControl;

#import <Foundation/Foundation.h>

@protocol DoubleTapSegmentedControlDelegate <NSObject>
- (void) performSegmentAction: (DoubleTapSegmentedControl *) sender;
@end
