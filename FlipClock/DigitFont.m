//
//  DigitFont.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

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

@end

