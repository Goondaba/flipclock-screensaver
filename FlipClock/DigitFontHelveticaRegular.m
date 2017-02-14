//
//  DigitFontHelveticaRegular.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitFontHelveticaRegular.h"

@implementation DigitFontHelveticaRegular

- (id)init {
    
    if (self = [super init]) {
        
        self.largeFont = [NSFont fontWithName:@"Helvetica" size:999.f];
        self.medianFont = [NSFont fontWithName:@"Helvetica" size:300.f];
    }
    return self;
}

@end
