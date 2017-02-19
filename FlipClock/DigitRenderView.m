//
//  DigitRenderView.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitRenderView.h"

@implementation DigitRenderView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.backgroundColour) {
        [self.backingView setWantsLayer:YES];
        [self.backingView.layer setBackgroundColor:[self.backgroundColour CGColor]];
    }
}

@end
