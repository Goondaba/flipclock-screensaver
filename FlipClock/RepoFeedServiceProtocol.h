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


/**
 The latest version available from Github.
 Is only populated if the latest Github version is newer than the current version.
 Nil otherwise.

 @return version string
 */
- (NSString *)latestVersion;

@end
