//
//  DoubleTapSegmentedControl.h
//  chabaike
//
//  Created by dzs on 12-5-8.
//  Copyright 2012年 maimaicha All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoubleTapSegmentedControlDelegate.h"

@interface DoubleTapSegmentedControl : UISegmentedControl {
    id <DoubleTapSegmentedControlDelegate> delegate;
}
@property (nonatomic, retain) id delegate;
@end
