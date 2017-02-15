//
//  NSImage+Flipclock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/12/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "NSImage+Flipclock.h"

@implementation NSImage (Flipclock)

- (void)splitImageVertically:(NSImage **)firstImage secondImage:(NSImage **)secondImage {
    
    *secondImage  = [self renderHalfWithStartingY:0.f];
    *firstImage = [self renderHalfWithStartingY:(self.size.height/2.0)];
    
    return;
}


- (NSImage *)renderHalfWithStartingY:(CGFloat)startY {
    
    NSImage *target = [[NSImage alloc]initWithSize:NSMakeSize(self.size.width, self.size.height/2.0)];
    
    //start drawing on target
    [target lockFocus];
    //draw the portion of the source image on target image
    [self drawInRect:NSMakeRect(0,0,target.size.width,target.size.height)
            fromRect:NSMakeRect(0,startY,self.size.width,(self.size.height/2.0))
           operation:NSCompositeCopy
            fraction:1.0];
    
    //end drawing
    [target unlockFocus];
    
    //create a NSBitmapImageRep
    NSBitmapImageRep *bmpImageRep = [[NSBitmapImageRep alloc]initWithData:[target TIFFRepresentation]];
    //add the NSBitmapImage to the representation list of the target
    [target addRepresentation:bmpImageRep];
    
    //get the data from the representation
    NSData *data = [bmpImageRep representationUsingType: NSJPEGFileType
                                             properties: nil];
    
    return [[NSImage alloc] initWithData:data];
}

@end
