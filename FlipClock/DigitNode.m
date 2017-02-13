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
//  DigitNode.m
//  ClockDemo
//
//  Created by Jonathan Salvador on 11/25/12.
//  Copyright (c) 2012 Jonathan Salvador. All rights reserved.
//

#import "DigitNode.h"
#import "DigitAnimationDelegate.h"
#import "DigitAnimationModel.h"
#import "SCNPlane+FlipClock.h"
#import "DigitNodeImageGeneratorUtil.h"
#import "NSImage+Flipclock.h"

@implementation DigitNode
@synthesize currentTexturePrefix;

CGFloat flipSegementWidth = 6.0;
CGFloat flipSegmentHeight = 4.5;
CGFloat flipSegementGap   = 0.005;
CGFloat flipSegmentZGap   = 0.01;


+(CGFloat)getDigitWidth{
    return flipSegementWidth;
}

-(void)flipToDigit:(DigitType)givenDigitType{
    
    DigitType fromType;
    
    //send digit-flipping-from information
    if(givenDigitType == kZero)
        fromType = kNine;
    else if (givenDigitType == kAM)
        fromType = kPM;
    else
        fromType = givenDigitType - 1;
    
    [self flipToTexturePrefix:[DigitNode getTexturePrefixFor:givenDigitType] fromPrefix:[DigitNode getTexturePrefixFor:fromType]];
}

-(void)flipToTexturePrefix:(NSString*)givenPrefix fromPrefix:(NSString*)givenOldPrefix{
    
    if([givenPrefix isEqualToString:self->currentTexturePrefix])
        return; //no flip necessary
    
    //create the flip node, that will contain the flip segments
    SCNNode *flipNode = [SCNNode node];
    [self addChildNode:flipNode];
    
    //create new top front plane
    SCNPlane *newTopHalf       = [SCNPlane planeWithWidth:flipSegementWidth height:flipSegmentHeight];
    SCNNode  *newTopHalfNode   = [SCNNode nodeWithGeometry:newTopHalf];
    CATransform3D translateUpAndForward = CATransform3DMakeTranslation(0, flipSegmentHeight/2.0 + flipSegementGap, flipSegmentZGap); //up top and just a smidge in front
    newTopHalfNode.transform = translateUpAndForward;
    [flipNode addChildNode:newTopHalfNode];
    
    //create bottom top back plane
    SCNPlane *newBottomHalf       = [SCNPlane planeWithWidth:flipSegementWidth height:flipSegmentHeight];
    SCNNode  *newBottomHalfNode   = [SCNNode nodeWithGeometry:newBottomHalf];
    CATransform3D turnAround      = CATransform3DMakeRotation(M_PI, 1.f, 0.f, 0.f);
    newBottomHalfNode.transform = CATransform3DConcat(turnAround, translateUpAndForward);
    [flipNode addChildNode:newBottomHalfNode];
    
    // set the newTopHalf texture
    [newTopHalf    applyMaterialWithName:[NSString stringWithFormat:@"%@_top", givenOldPrefix]];
    [newBottomHalf applyMaterialWithName:[NSString stringWithFormat:@"%@_bot", givenPrefix]];
    
    
    //update prefixString
    self->currentTexturePrefix = givenPrefix;
    
    [bottomHalf applyMaterialWithName:[NSString stringWithFormat:@"%@_bot", self->currentTexturePrefix]];
    
    //make it flip!
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(flipNode.transform, 0, 1.f, 0.f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(flipNode.transform, M_PI, 1.f, 0.f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(flipNode.transform, 31.0*(M_PI/32.0), 1.f, 0.f, 0.f)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(flipNode.transform, M_PI, 1.f, 0.f, 0.f)],
                        nil];
    animation.duration = 0.8f;
    animation.repeatCount = 0;
    
    //set values to animation for the delegate to use
    DigitAnimationModel *model = [[DigitAnimationModel alloc] init];
    model.texturePrefix = self.currentTexturePrefix;
    model.flipNode      = flipNode;
    model.topHalf       = topHalf;
    model.bottomHalf    = bottomHalf;
    
    DigitAnimationDelegate *delegate = [[DigitAnimationDelegate alloc] init];
    delegate.animationModel = model;
    animation.delegate = delegate;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [flipNode addAnimation:animation forKey:nil];
}

-(void)startDigitAt:(DigitType)givenDigitType{
    
    //get texture prefix
    self->currentTexturePrefix = [DigitNode getTexturePrefixFor:givenDigitType];
    
    //create top plane
    topHalf       = [SCNPlane planeWithWidth:flipSegementWidth height:flipSegmentHeight];
    SCNNode  *topHalfNode   = [SCNNode nodeWithGeometry:topHalf];
    CATransform3D translateUP = CATransform3DMakeTranslation(0, flipSegmentHeight/2.0 + flipSegementGap, 0);
    topHalfNode.transform = translateUP;
    [self addChildNode:topHalfNode];
    
    //create a plane
    bottomHalf       = [SCNPlane planeWithWidth:flipSegementWidth height:flipSegmentHeight];
    SCNNode  *bottomHalfNode   = [SCNNode nodeWithGeometry:bottomHalf];
    CATransform3D translateDOWN = CATransform3DMakeTranslation(0, -(flipSegmentHeight/2.0 + flipSegementGap), -0.1);
    bottomHalfNode.transform = translateDOWN;
    [self addChildNode:bottomHalfNode];
    
    // Give the top an image
    [topHalf    applyMaterialWithName:[NSString stringWithFormat:@"%@_top", self->currentTexturePrefix]];
    [bottomHalf applyMaterialWithName:[NSString stringWithFormat:@"%@_bot", self->currentTexturePrefix]];
}

//Do a one-time load of textures into the textures array
+ (NSDictionary<NSString *, NSImage*> *)textures {
    
    static dispatch_once_t token;
    static NSDictionary<NSString *, NSImage*> *shared = nil;
    
    dispatch_once(&token, ^{
        shared = [NSMutableDictionary dictionary];
        
        for(int i=0; i < numDigitType; i++){
            
            NSString *currentPrefix = [DigitNode getTexturePrefixFor:i];
            NSString *top_str       = [NSString stringWithFormat:@"%@_top", currentPrefix];
            NSString *bottom_str    = [NSString stringWithFormat:@"%@_bot", currentPrefix];
            
            if (i <= kNine) {
                NSColor *veryDarkGrey = [NSColor colorWithRed:0.06f green:0.06f blue:0.06f alpha:1];
                NSFont *font = [NSFont systemFontOfSize:999.f];
                NSImage *fullImage = [DigitNodeImageGeneratorUtil drawString:[NSString stringWithFormat:@"%d", i] withFont:font andBackgroundColour:veryDarkGrey];
                
                NSImage *firstImage = nil;
                NSImage *secondImage = nil;
                
                [fullImage splitImageVertically:&firstImage secondImage:&secondImage];
                
                [shared setValue:firstImage    forKey:top_str];
                [shared setValue:secondImage forKey:bottom_str];
            }
            else {
                [shared setValue:[DigitNode getImageForFileName:top_str]    forKey:top_str];
                [shared setValue:[DigitNode getImageForFileName:bottom_str] forKey:bottom_str];
            }
        }
    });
    
    return shared;
}

+(NSImage*)getImageForFileName:(NSString*)givenImageName{
    
     NSString *pathString = [[NSBundle bundleForClass:[self class]] pathForResource:givenImageName ofType:@"png"];
    return [[NSImage alloc] initWithContentsOfFile:pathString];
}

+(NSString*)getTexturePrefixFor:(DigitType)givenDigitType{
    switch(givenDigitType){
    case kZero:
        return @"zero";
        break;
    case kOne:
        return @"one";
        break;
    case kTwo:
        return @"two";
        break;
    case kThree:
        return @"three";
        break;
    case kFour:
        return @"four";
        break;
    case kFive:
        return @"five";
        break;
    case kSix:
        return @"six";
        break;
    case kSeven:
        return @"seven";
        break;
    case kEight:
        return @"eight";
        break;
    case kNine:
        return @"nine";
        break;
    case kAM:
        return @"am";
        break;
    case kPM:
        return @"pm";
        break;
    default:
        return @"zero";
        break;
    }
}

@end
