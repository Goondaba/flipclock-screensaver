//
//  DigitMedianRenderView.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DigitMedianRenderView : NSView

@property (nonatomic, weak) IBOutlet NSView *backingView;
@property (nonatomic, weak) IBOutlet NSTextField *topTextField;
@property (nonatomic, weak) IBOutlet NSTextField *bottomTextField;

@property (nonatomic, strong) NSColor *backgroundColour;

@end
