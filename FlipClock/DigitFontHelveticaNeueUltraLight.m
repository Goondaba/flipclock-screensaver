//
//  DigitFontHelveticaNeueUltraLight.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitFontHelveticaNeueUltraLight.h"

@implementation DigitFontHelveticaNeueUltraLight

- (id)init {
    
    if (self = [super init]) {
        
        self.largeFont = [NSFont fontWithName:@"HelveticaNeue-UltraLight" size:999.f];
        self.medianFont = [NSFont fontWithName:@"HelveticaNeue-UltraLight" size:300.f];
    }
    return self;
}

@end
