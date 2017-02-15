//
//  NSImage+Flipclock.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Flipclock)

- (void)splitImageVertically:(NSImage **)firstImage secondImage:(NSImage **)secondImage;

@end
