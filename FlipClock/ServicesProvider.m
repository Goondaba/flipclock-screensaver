//
//  ServicesProvider.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/15/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "ServicesProvider.h"
#import "RepoFeedService.h"
#import "TextureProviderService.h"

@implementation ServicesProvider


+ (instancetype)instance {
    
    static dispatch_once_t token;
    static ServicesProvider *shared = nil;
    
    dispatch_once(&token, ^{

        shared = [ServicesProvider new];
        
        shared.feedService = [RepoFeedService new];
        shared.textureService = [TextureProviderService new];
        //TODO: Add texture generator to services
    });
    
    return shared;
}

@end
