//
//  DigitAnimationContainer.h
//  FlipClock
//
//  Created by Jonathan Salvador on 7/26/15.
//  Copyright (c) 2015 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigitAnimationModel : NSObject

@property (nonatomic, copy) NSString  *texturePrefix;
@property (nonatomic, weak) SCNNode   *flipNode;
@property (nonatomic, weak) SCNPlane  *topHalf;
@property (nonatomic, weak) SCNPlane  *bottomHalf;

@end
