//
//  TextureProviderService.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "TextureProviderService.h"

@interface TextureProviderService ()
@property (nonatomic, strong) NSDictionary<NSString *, NSImage*> *textures;
@end

@implementation TextureProviderService

- (NSDictionary<NSString *, NSImage*> *)textures {
    return _textures;
}

- (void)loadTexturesWithFontType:(DigitFontType)fontType {
    
    //TODO: Move to pre-built images for efficiency
    self.textures = [DigitNodeImageGeneratorUtil generateTexturesWithFontType:fontType];
}


@end
