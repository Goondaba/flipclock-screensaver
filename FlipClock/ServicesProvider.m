//
//  ServicesProvider.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/15/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "ServicesProvider.h"

@implementation ServicesProvider


+ (instancetype)instance {
    
    static dispatch_once_t token;
    static ServicesProvider *shared = nil;
    
    dispatch_once(&token, ^{

    });
    
    return shared;
}

@end