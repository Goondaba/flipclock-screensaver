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
#import "Constants.h"
#import "VersionUtil.h"

typedef NS_ENUM(NSInteger, VersionRegexGroupSequence) {
    VersionRegexGroupSequenceName = 1,
    VersionRegexGroupSequenceVersion,
};


@interface RepoFeedService () <MWFeedParserDelegate>
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (copy) newReleaseFetchCompletionBlock completionCallback;
@property (nonatomic, strong) NSMutableArray<NSString *> *titleList;
@property (nonatomic, strong) NSString *latestVersion;
@end

@implementation RepoFeedService

- (id)init {
    
    if (self = [super init]) {
        self.titleList = [NSMutableArray new];
        self.latestVersion = nil;
    }
    return self;
}

- (void)newReleaseIsAvailable:(void (^) (BOOL newReleaseAvailable))completion {
    
    if (!self.feedParser) {
        NSURL *feedURL = [self repoURL];
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

- (NSString *)latestVersion {
    return _latestVersion;
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
    
    if (self.titleList.count > 0) {
        
        NSString *latestVersion = [self latestVersionStringFromTitleString:[self.titleList firstObject]];
        if (latestVersion) {
            
            //Grab current version
            NSString *currentVersion = [VersionUtil currentVersion];
            BOOL newerVersionExists = [latestVersion isNewerThanVersion:currentVersion];
            if (newerVersionExists) {
                self.latestVersion = latestVersion;
            }
            
            self.completionCallback (newerVersionExists);
            return;
        }
    }
    
    self.completionCallback(NO);
}

#pragma mark - Custom 

- (NSString *)latestVersionStringFromTitleString:(NSString *)string {
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s*(\\w+)\\s+(\\S+)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, [string length])];
    for (NSTextCheckingResult *match in matches) {
        
        @try {
            return [string substringWithRange:[match rangeAtIndex:VersionRegexGroupSequenceVersion]];
        } @catch (NSException *exception) {
            return nil;
        }
    }
    
    return nil;
}

- (NSURL *)repoURL {
    
    NSString *fullURLString = [NSString stringWithFormat:@"%@.atom", kGithubURLString];
    return [NSURL URLWithString:fullURLString];
}

@end
