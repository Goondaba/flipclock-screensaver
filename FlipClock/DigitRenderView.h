//
//  DigitRenderView.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DigitRenderView : NSView

@property (nonatomic, weak) IBOutlet NSView *backingView;
@property (nonatomic, weak) IBOutlet NSTextField *textField;

@property (nonatomic, strong) NSColor *backgroundColour;

@end
