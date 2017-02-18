//
//  DigitNodeTextureNameUtil.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitNodeTextureNameUtil.h"
#import "DigitNodeTypes.h"


@implementation DigitNodeTextureNameUtil

+(NSString*)getTexturePrefixFor:(DigitType)givenDigitType{
    switch(givenDigitType){
        case kZero:
            return @"zero";
            break;
        case kOne:
            return @"one";
            break;
        case kTwo:
            return @"two";
            break;
        case kThree:
            return @"three";
            break;
        case kFour:
            return @"four";
            break;
        case kFive:
            return @"five";
            break;
        case kSix:
            return @"six";
            break;
        case kSeven:
            return @"seven";
            break;
        case kEight:
            return @"eight";
            break;
        case kNine:
            return @"nine";
            break;
        case kAM:
            return @"am";
            break;
        case kPM:
            return @"pm";
            break;
        default:
            return @"zero";
            break;
    }
}

@end
