//
//  DigitNodeImageGeneratorUtil.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigitNodeImageGeneratorUtil : NSObject

+ (NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size;
+ (NSImage *)drawString:(NSString *)attributedString withFont:(NSFont *)font andBackgroundColour:(NSColor *)backgroundColour;

@end
