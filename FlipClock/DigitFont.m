//
//  DigitFont.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DigitFont.h"

@interface DigitFont ()
@property (nonatomic, assign) DigitFontType fontType;
@end


@implementation DigitFont

- (id)initWithFontType:(DigitFontType)fontType {
    
    if (self = [super init]) {
        
        self.fontType = fontType;
        
        if (fontType == kDigitFontTypeHelveticaRegular) {
            self.largeFont = [NSFont fontWithName:@"Helvetica" size:999.f];
            self.medianFont = [NSFont fontWithName:@"Helvetica" size:300.f];
        }
        else {
            self.largeFont = [NSFont fontWithName:@"HelveticaNeue-UltraLight" size:999.f];
            self.medianFont = [NSFont fontWithName:@"HelveticaNeue-UltraLight" size:300.f];
        }
    }
    return self;
}

+ (NSString *)fontNameForType:(DigitFontType)fontType {
    
    NSString *result = nil;
    
    switch(fontType) {
        case kDigitFontTypeHelveticaRegular:
            result = @"Helvetica Regular";
            break;
        case kDigitFontTypeHelveticaNeueUltraLight:
            result = @"Helvetica Neue UltraLight";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    
    return result;
}

@end

