//
//  CAAnimation+FlipClock.h
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "DigitAnimationModel.h"

@interface CAAnimation (FlipClock)
@property (nonatomic, strong) DigitAnimationModel *animationModel;
@end
