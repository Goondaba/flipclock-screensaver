//
//  DigitNodeImageGeneratorUtil.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DigitFont.h"

typedef NS_ENUM(NSInteger, DigitMedianDrawType) {
    kDigitMedianDrawTypeAM,
    kDigitMedianDrawTypePM
};

@interface DigitNodeImageGeneratorUtil : NSObject

+ (NSDictionary<NSString *, NSImage*> *)generateTexturesWithFontType:(DigitFontType)fontType;


@end
