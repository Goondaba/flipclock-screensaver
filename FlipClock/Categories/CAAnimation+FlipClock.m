//
//  CAAnimation+FlipClock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "CAAnimation+FlipClock.h"


@implementation CAAnimation (FlipClock)

@dynamic animationContainer;

- (void)setAnimationContainer:(DigitAnimationContainer *)object {
    objc_setAssociatedObject(self, @selector(animationContainer), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DigitAnimationContainer *)animationContainer {
    return objc_getAssociatedObject(self, @selector(animationContainer));
}

@end
