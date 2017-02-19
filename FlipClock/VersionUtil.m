//
//  VersionUtil.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/19/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "VersionUtil.h"

@implementation VersionUtil

+ (NSString *)currentVersion {
    
    return [NSString stringWithFormat:@"%@",[[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

@end
