//
//  SCNNode+FlipClock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "SCNNode+FlipClock.h"

@implementation SCNNode (FlipClock)

- (void)cleanupAndRemoveFromParentNode {
    
    self.geometry = nil;
    [self removeAllAnimations];
    [self removeFromParentNode];
}

@end
