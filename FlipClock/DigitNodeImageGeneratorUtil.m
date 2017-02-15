//
//  DigitNodeImageGeneratorUtil.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "DigitNodeImageGeneratorUtil.h"
#import "DigitRenderView.h"
#import "DigitMedianRenderView.h"

@implementation DigitNodeImageGeneratorUtil


+ (NSImage *)drawString:(NSString *)string withFont:(NSFont *)font andBackgroundColour:(NSColor *)backgroundColour {
    
    /// Get view
    DigitRenderView *renderView = [self getTopViewFromNibWithClass:[DigitRenderView class]];
    
    if (renderView == nil) {
        return nil;
    }
    
    renderView.backgroundColour = backgroundColour;
    renderView.textField.stringValue = string;
    renderView.textField.cell.font = font;
    
    [renderView updateConstraints];
    
    ///Render
    NSImage *image = [self renderViewToImage:renderView];
    
    return image;
}

+ (NSImage *)drawMedianWithType:(DigitMedianDrawType)type withFont:(NSFont *)font andBackgroundColour:(NSColor *)backgroundColour {
    
    /// Get view
    DigitMedianRenderView *renderView = [self getTopViewFromNibWithClass:[DigitMedianRenderView class]];
    
    if (renderView == nil) {
        return nil;
    }
    
    renderView.backgroundColour = backgroundColour;
    renderView.topTextField.cell.font = font;
    renderView.bottomTextField.cell.font = font;
    
    if (type == kDigitMedianDrawTypeAM) {
        renderView.bottomTextField.hidden = YES;
    }
    else {
        renderView.bottomTextField.hidden = YES;
    }
    
    [renderView updateConstraints];
    
    ///Render
    NSImage *image = [self renderViewToImage:renderView];
    
    return image;
}


#pragma mark - Private

+ (NSView *)getTopViewFromNibWithClass:(Class)class {
    
    NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(class) bundle:[NSBundle bundleForClass:[self class]]];
    NSArray *topLevelObjects;
    [nib instantiateWithOwner:self topLevelObjects:&topLevelObjects];
    
    for (id topLevelObject in topLevelObjects) {
        if ([topLevelObject isKindOfClass:class]) {
            return topLevelObject;
        }
    }
    
    return nil;
}

+ (NSImage *)renderViewToImage:(NSView *)renderView {
    
    NSBitmapImageRep* rep = [renderView bitmapImageRepForCachingDisplayInRect:renderView.bounds];
    [renderView cacheDisplayInRect:renderView.bounds toBitmapImageRep:rep];
    NSData* data = [rep representationUsingType:NSJPEGFileType properties:nil];
    
    return [[NSImage alloc] initWithData:data];
}

@end
