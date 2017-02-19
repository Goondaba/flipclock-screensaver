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
#import "NSImage+Flipclock.h"
#import "DigitNodeTypes.h"
#import "DigitNodeTextureNameUtil.h"

typedef NS_ENUM(NSInteger, DigitMedianDrawType) {
    kDigitMedianDrawTypeAM,
    kDigitMedianDrawTypePM
};

@implementation DigitNodeImageGeneratorUtil

+ (NSDictionary<NSString *, NSImage*> *)generateTexturesWithFontType:(DigitFontType)fontType {
    
    if (fontType < 0) {
        return nil;
    }
    
    NSDictionary<NSString *, NSImage*> *shared = [NSMutableDictionary dictionary];

    DigitFont *nodeFont = [[DigitFont alloc] initWithFontType:fontType];
    
    NSColor *veryDarkGrey = [NSColor colorWithRed:0.06f green:0.06f blue:0.06f alpha:1];
    
    for(int i=0; i < numDigitType; i++){
        
        NSString *currentPrefix = [DigitNodeTextureNameUtil getTexturePrefixFor:i];
        NSString *top_str       = [NSString stringWithFormat:@"%@_top", currentPrefix];
        NSString *bottom_str    = [NSString stringWithFormat:@"%@_bot", currentPrefix];
        NSImage *fullImage = nil;
        
        if (i <= kNine) {
            
            fullImage = [DigitNodeImageGeneratorUtil drawString:[NSString stringWithFormat:@"%d", i] withFont:nodeFont.largeFont andBackgroundColour:veryDarkGrey];
        }
        else {
            
            DigitMedianDrawType medianType = (i == kAM) ? kDigitMedianDrawTypeAM : kDigitMedianDrawTypePM;
            fullImage = [DigitNodeImageGeneratorUtil drawMedianWithType:medianType withFont:nodeFont.medianFont andBackgroundColour:veryDarkGrey];
        }
        
        NSImage *firstImage = nil;
        NSImage *secondImage = nil;
        
        [fullImage splitImageVertically:&firstImage secondImage:&secondImage];
        
        [shared setValue:firstImage    forKey:top_str];
        [shared setValue:secondImage forKey:bottom_str];
    }
    
    return shared;
}

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
        renderView.topTextField.hidden = YES;
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
