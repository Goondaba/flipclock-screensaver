//
//  RepoFeedServiceProtocol.h
//  FlipClock
//
//  Created by Jonathan Salvador on 2/15/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^newReleaseFetchCompletionBlock)(BOOL newReleaseAvailable);

@protocol RepoFeedServiceProtocol <NSObject>

- (void)newReleaseIsAvailable:(newReleaseFetchCompletionBlock)completion;

@end
