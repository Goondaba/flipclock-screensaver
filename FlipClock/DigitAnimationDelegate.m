//The MIT License (MIT) Copyright (c) <2013> <Jonathan Salvador>
//
//Permission is hereby granted, free of charge, to any person obtaining a
//copy of this software and associated documentation files (the
//"Software"), to deal in the Software without restriction, including
//without limitation the rights to use, copy, modify, merge, publish,
//distribute, sublicense, and/or sell copies of the Software, and to
//permit persons to whom the Software is furnished to do so, subject to
//the following conditions:
//
//The above copyright notice and this permission notice shall be included
//in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  DigitAnimationDelegate.m
//  ClockDemo
//
//  Created by Jonathan Salvador on 1/24/13.
//  Copyright (c) 2013 Jonathan Salvador. All rights reserved.
//

#import "DigitAnimationDelegate.h"

@implementation DigitAnimationDelegate

-(id)initWithNode:(SCNNode*)givenNode andTop:(SCNPlane*)givenTopHalf andBottom:(SCNPlane*)givenBottomHalf andPrefix:(NSString*)givenPrefix andPlanes:(NSArray*)givenPlanes  andNodes:(NSArray*)givenNodes{
    if (self = [super init]){
        // Initialization code here
        self->flipNode      = givenNode;
        self->topHalf       = givenTopHalf;
        self->bottomHalf    = givenBottomHalf;
        self->texturePrefix = givenPrefix;
        self->planes        = givenPlanes;
        self->nodes         = givenNodes;
    }
    return self;
}

- (void)animationDidStart:(CAAnimation *)theAnimation{
    
    //update topHalf
    [DigitNode giveSegment:topHalf MaterialWithName:[NSString stringWithFormat:@"%@_top", texturePrefix]];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
    
    if(flag){
        
        //update bottomHalf
        [DigitNode giveSegment:bottomHalf MaterialWithName:[NSString stringWithFormat:@"%@_bot", texturePrefix]];
        
        //Nil the NSImages in the given material array
        for (SCNPlane* __strong currentPlane in planes) {
            SCNMaterial *currentMaterial = [[currentPlane materials] objectAtIndex:0];
            currentMaterial.diffuse.contents = nil;
            currentMaterial = nil;
            currentPlane = nil;
        }
        
        for(SCNNode* __strong currentNode in nodes){
            [currentNode removeFromParentNode];
            currentNode = nil;
        }
        
        //remove flipper
        [flipNode removeFromParentNode];
        flipNode = nil;
    }
}

@end
