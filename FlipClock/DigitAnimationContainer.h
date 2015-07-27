//
//  DigitAnimationContainer.h
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigitAnimationContainer : NSObject

@property (nonatomic, copy) NSString  *texturePrefix;
@property (nonatomic, copy) SCNNode   *flipNode;
@property (nonatomic) SCNPlane  *topHalf;
@property (nonatomic) SCNPlane  *bottomHalf;
@property (nonatomic) NSArray   *planes;
@property (nonatomic) NSArray   *nodes;

@end
