//
//  TextureProviderServiceProtocol.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DigitNodeImageGeneratorUtil.h"

@protocol TextureProviderServiceProtocol <NSObject>

- (void)loadTexturesWithFontType:(DigitFontType)fontType;

- (NSDictionary<NSString *, NSImage*> *)textures;

@end
