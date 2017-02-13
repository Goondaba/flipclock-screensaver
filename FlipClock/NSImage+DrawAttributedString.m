#import "NSImage+DrawAttributedString.h"

@implementation NSImage (DrawAttributedString)

+ (NSImage *)imageWithAttributedString:(NSAttributedString *)attributedString
                       backgroundColor:(NSColor *)backgroundColor {
    
    NSSize boxSize = [attributedString size];
    NSRect rect = NSMakeRect(0.0, 0.0, boxSize.width, boxSize.height);
    NSImage *image = [[NSImage alloc] initWithSize:boxSize];
    
    [image lockFocus];
    
    [backgroundColor set];
    NSRectFill(rect);
    
    [attributedString drawInRect:rect];
    
    [image unlockFocus];
    
    return image;
}

+ (NSImage *)imageWithAttributedString:(NSAttributedString *)attributedString {
    
    return [self imageWithAttributedString:attributedString
                           backgroundColor:[NSColor clearColor]];
}

+ (NSImage *)imageWithString:(NSString *)string {
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string];
    return [self imageWithAttributedString:attrString];
}

@end
