//
//  DigitNodeTextureNameUtil.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DigitNodeTypes.h"

@interface DigitNodeTextureNameUtil : NSObject

+(NSString*)getTexturePrefixFor:(DigitType)givenDigitType;

@end
