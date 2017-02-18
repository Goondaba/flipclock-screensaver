//
//  TextureProviderService.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "TextureProviderService.h"
#import "DigitNodeTextureNameUtil.h"
#import "NSImage+Flipclock.h"

@interface TextureProviderService ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSImage*> *textures;
@end

@implementation TextureProviderService

- (NSDictionary<NSString *, NSImage*> *)textures {
    return _textures;
}

- (void)loadTexturesWithFontType:(DigitFontType)fontType {

    if (!self.textures) {
        self.textures = [NSMutableDictionary dictionary];
    }
    
    for(int i=0; i < numDigitType; i++){
        
        NSString *currentPrefix = [DigitNodeTextureNameUtil getTexturePrefixFor:i];
        
        //name to save resources under
        NSString *top_str       = [NSString stringWithFormat:@"%@_top", currentPrefix];
        NSString *bottom_str    = [NSString stringWithFormat:@"%@_bot", currentPrefix];
        
        //name to use to load image resources
        NSString *topLoadName    = [NSString stringWithFormat:@"%@_%ld", top_str, (long)fontType];
        NSString *bottomLoadName = [NSString stringWithFormat:@"%@_%ld", bottom_str, (long)fontType];
        
        [self.textures setValue:[self getImageForFileName:topLoadName]    forKey:top_str];
        [self.textures setValue:[self getImageForFileName:bottomLoadName] forKey:bottom_str];
    }
}

- (NSImage *)getImageForFileName:(NSString*)givenImageName{
    
    NSString *pathString = [[NSBundle bundleForClass:[self class]] pathForResource:givenImageName ofType:@"png"];
    return [[NSImage alloc] initWithContentsOfFile:pathString];
}

@end
