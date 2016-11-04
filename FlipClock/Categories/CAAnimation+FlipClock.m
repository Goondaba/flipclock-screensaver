//
//  CAAnimation+FlipClock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "CAAnimation+FlipClock.h"


@implementation CAAnimation (FlipClock)

@dynamic animationModel;

- (void)setAnimationModel:(DigitAnimationModel *)object {
    objc_setAssociatedObject(self, @selector(animationModel), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DigitAnimationModel *)animationModel {
    return objc_getAssociatedObject(self, @selector(animationModel));
}

@end
