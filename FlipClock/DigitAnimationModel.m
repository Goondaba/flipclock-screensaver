//
//  DigitAnimationContainer.m
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "DigitAnimationModel.h"

/**
 *  Container for information needed by the flip animation delegate
 */
@implementation DigitAnimationModel

- (void)dealloc {
    
    self.texturePrefix = nil;
    self.flipNode      = nil;
    self.topHalf       = nil;
    self.bottomHalf    = nil;
}

@end
