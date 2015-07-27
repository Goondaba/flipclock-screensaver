//
//  CAAnimation+FlipClock.h
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "DigitAnimationContainer.h"

@interface CAAnimation (FlipClock)
@property (nonatomic, strong) DigitAnimationContainer *animationContainer;
@end
