//
//  DigitNodeImageGeneratorUtil.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitNodeImageGeneratorUtil.h"
#import "DigitRenderView.h"

@implementation DigitNodeImageGeneratorUtil


+ (NSImage *)swatchWithColor:(NSColor *)color size:(NSSize)size {
    NSImage *image = [[NSImage alloc] initWithSize:size];
    
    [image lockFocus];
        [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
    
    return image;
}

+ (NSImage *)drawString:(NSString *)attributedString withFont:(NSFont *)font andBackgroundColour:(NSColor *)backgroundColour {
    
    /// Get view
    NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass([DigitRenderView class]) bundle:nil];
    NSArray *topLevelObjects;
    [nib instantiateWithOwner:self topLevelObjects:&topLevelObjects];
    
    DigitRenderView *renderView = nil;
    for (id topLevelObject in topLevelObjects) {
        if ([topLevelObject isKindOfClass:[DigitRenderView class]]) {
            renderView = topLevelObject;
            break;
        }
    }
    
    if (renderView == nil) {
        return nil;
    }
    
    renderView.backgroundColour = backgroundColour;
    
    ///Render
    NSBitmapImageRep* rep = [renderView bitmapImageRepForCachingDisplayInRect:renderView.bounds];
    [renderView cacheDisplayInRect:renderView.bounds toBitmapImageRep:rep];
    NSData* data = [rep representationUsingType:NSJPEGFileType properties:nil];
    NSImage *image = [[NSImage alloc] initWithData:data];
    
    return image;
}

@end