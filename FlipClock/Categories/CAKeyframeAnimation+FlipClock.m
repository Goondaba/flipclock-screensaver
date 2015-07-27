//
//  CAKeyframeAnimation+FlipClock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import "CAKeyframeAnimation+FlipClock.h"

//NSString *texturePrefix;
//SCNNode  *flipNode;
//SCNPlane *topHalf;
//SCNPlane *bottomHalf;
//NSArray  *planes;
//NSArray  *nodes;

//static char kTexturePrefixKey;
//static char kAssociatedObjectKey;
//static char kAssociatedObjectKey;
//static char kAssociatedObjectKey;
//static char kAssociatedObjectKey;
//static char kAssociatedObjectKey;

@implementation CAKeyframeAnimation (FlipClock)

@dynamic texturePrefix;

- (void)setTexturePrefix:(id)object {
    objc_setAssociatedObject(self, @selector(texturePrefix), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)texturePrefix {
    return objc_getAssociatedObject(self, @selector(texturePrefix));
}

@end
