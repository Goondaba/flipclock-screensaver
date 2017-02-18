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

typedef NS_ENUM(NSInteger, VersionRegexGroupSequence) {
    VersionRegexGroupSequenceName = 1,
    VersionRegexGroupSequenceVersion,
};


@interface RepoFeedService () <MWFeedParserDelegate>
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (copy) newReleaseFetchCompletionBlock completionCallback;
@property (nonatomic, strong) NSMutableArray<NSString *> *titleList;
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
    
    if (self.titleList.count > 0) {
        
        NSString *latestVersion = [self latestVersionStringFromTitleString:[self.titleList firstObject]];
        if (latestVersion) {
            
            //Grab current version
            NSString *currentVersion = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
            
            self.completionCallback ([latestVersion isNewerThanVersion:currentVersion]);
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
@end
