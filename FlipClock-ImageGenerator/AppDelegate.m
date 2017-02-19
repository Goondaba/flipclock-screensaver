//
//  AppDelegate.m
//  FlipClock-ImageGenerator
//
//  Created by Jonathan Salvador on 2/17/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "AppDelegate.h"
#import "DigitNodeImageGeneratorUtil.h"
#import "DigitFont.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    //for each font
    for (NSInteger i=0; i < kDigitFontTypeCount; i++) {
        
        NSDictionary<NSString *, NSImage*> *textures = [DigitNodeImageGeneratorUtil generateTexturesWithFontType:i];
        
        //for every digit
        for (NSString *key in textures) {
            NSImage *image = [textures objectForKey:key];
            
            NSString *imageName = [NSString stringWithFormat:@"%@_%ld.png", key, (long)i];
            
            [self saveImage:image withName:imageName];
        }
    }
    
    NSLog(@"Done!");
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


#pragma mark - Custom

- (void)saveImage:(NSImage *)image withName:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];
    
    
    CGImageRef cgRef = [image CGImageForProposedRect:NULL
                                             context:nil
                                               hints:nil];
    NSBitmapImageRep *newRep = [[NSBitmapImageRep alloc] initWithCGImage:cgRef];
    [newRep setSize:[image size]];   // if you want the same resolution
    
    NSLog(@"Writing %@...", filePath);
    NSData *pngData = [newRep representationUsingType:NSPNGFileType properties:nil];
    [pngData writeToFile:filePath atomically:YES];
}


@end
