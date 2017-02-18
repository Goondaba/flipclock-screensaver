//
//  ServicesProvider.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/15/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RepoFeedServiceProtocol.h"

@interface ServicesProvider : NSObject

+ (instancetype)instance;

@property (nonatomic, strong) id<RepoFeedServiceProtocol> feedService;

@end
