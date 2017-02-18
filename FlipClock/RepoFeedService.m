//
//  RepoFeedService.m
//  FlipClock
//
//  Created by Jonathan Salvador on 2/15/17.
//  Copyright © 2017 Jonathan Salvador. All rights reserved.
//

#import "RepoFeedService.h"
#import <MWFeedParser/MWFeedParser.h>
#import <MWFeedParser/NSString+HTML.h>
#import <NSString-comparetoVersion/NSString+CompareToVersion.h>

static NSString * const kRepoURL = @"https://github.com/Goondaba/flipclock-screensaver/releases.atom";

@interface RepoFeedService () <MWFeedParserDelegate>
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (copy) newReleaseFetchCompletionBlock completionCallback;
@property (nonatomic, strong) NSMutableArray *titleList;
@end

@implementation RepoFeedService

- (id)init {
    
    if (self = [super init]) {
        self.titleList = [NSMutableArray new];
    }
    return self;
}

- (void)newReleaseIsAvailable:(void (^) (BOOL newReleaseAvailable))completion {
    
    if (!self.feedParser) {
        NSURL *feedURL = [NSURL URLWithString:kRepoURL];
        self.feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    }
    
    //prepare
    [self.feedParser stopParsing];
    [self.titleList removeAllObjects];
    
    self.feedParser.delegate = self;
    self.feedParser.feedParseType = ParseTypeItemsOnly;
    self.feedParser.connectionType = ConnectionTypeAsynchronously;
    
    self.completionCallback = completion;
    [self.feedParser parse];
}

#pragma mark - MWFeedParser Delegate

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    
    NSString *title = item.title;
    if (title) {
        [self.titleList addObject:[title stringByRemovingNewLinesAndWhitespace]];
    }
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    //TODO: error handling
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    
    //Grab current version
    
    //Parse out numerical portion of title
    
    //TODO: Trigger callback
    NSLog(@"%@", self.titleList);
}


@end
