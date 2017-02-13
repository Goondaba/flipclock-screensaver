#import <AppKit/AppKit.h>

@interface NSImage (DrawAttributedString)

+ (NSImage *)imageWithAttributedString:(NSAttributedString *)attributedString
                       backgroundColor:(NSColor *)backgroundColor;
+ (NSImage *)imageWithAttributedString:(NSAttributedString *)attributedString;
+ (NSImage *)imageWithString:(NSString *)string;

@end
