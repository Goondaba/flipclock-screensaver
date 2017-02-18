//
//  DigitNodeImageGeneratorUtil.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DigitFont.h"

@interface DigitNodeImageGeneratorUtil : NSObject

+ (NSDictionary<NSString *, NSImage*> *)generateTexturesWithFontType:(DigitFontType)fontType;

@end
