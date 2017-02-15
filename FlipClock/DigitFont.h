//
//  DigitFont.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/13/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DigitFontType) {
    kDigitFontTypeHelveticaRegular,
    kDigitFontTypeHelveticaNeueUltraLight,
    kDigitFontTypeCount
};

@interface DigitFont : NSObject

@property (nonatomic, strong) NSFont *largeFont;
@property (nonatomic, strong) NSFont *medianFont;

- (id)initWithFontType:(DigitFontType)fontType;
+ (NSString *)fontNameForType:(DigitFontType)fontType;

@end
