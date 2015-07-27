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

@implementation DigitNode
@synthesize currentTexturePrefix;

CGFloat flipSegementWidth = 6.0;
CGFloat flipSegmentHeight = 4.5;
CGFloat flipSegementGap   = 0.005;
CGFloat flipSegmentZGap   = 0.01;

NSMutableDictionary *textures = nil;

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
    [DigitNode giveSegment:newTopHalf    MaterialWithName:[NSString stringWithFormat:@"%@_top", givenOldPrefix]];
    [DigitNode giveSegment:newBottomHalf MaterialWithName:[NSString stringWithFormat:@"%@_bot", givenPrefix]];
    
    
    //update prefixString
    self->currentTexturePrefix = givenPrefix;
    
    [DigitNode giveSegment:bottomHalf MaterialWithName:[NSString stringWithFormat:@"%@_bot", self->currentTexturePrefix]];
    
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
    animation.texturePrefix = self.currentTexturePrefix;
    animation.delegate = [[DigitAnimationDelegate alloc] initWithNode:flipNode andTop:topHalf andBottom:bottomHalf andPrefix:self->currentTexturePrefix andPlanes:@[newTopHalf, newBottomHalf] andNodes:@[newTopHalfNode, newBottomHalfNode]];
  
    animation.removedOnCompletion = YES;
    [flipNode addAnimation:animation forKey:nil];
}

-(void)startDigitAt:(DigitType)givenDigitType{
    
    [DigitNode loadTextures];
    
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
    [DigitNode giveSegment:topHalf    MaterialWithName:[NSString stringWithFormat:@"%@_top", self->currentTexturePrefix]];
    [DigitNode giveSegment:bottomHalf MaterialWithName:[NSString stringWithFormat:@"%@_bot", self->currentTexturePrefix]];
}

//Do a one-time load of textures into the textures array
+(void)loadTextures{
    @synchronized(textures){
        if(nil == textures){
            textures = [NSMutableDictionary dictionary];
            
            for(int i=0; i < numDigitType; i++){
                
                NSString *currentPrefix = [DigitNode getTexturePrefixFor:i];
                NSString *top_str       = [NSString stringWithFormat:@"%@_top", currentPrefix];
                NSString *bottom_str    = [NSString stringWithFormat:@"%@_bot", currentPrefix];

                [textures setObject:[DigitNode getImageForFileName:top_str]     forKey:top_str];
                [textures setObject:[DigitNode getImageForFileName:bottom_str]  forKey:bottom_str];

            }
        }
    }
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

+(void)giveSegment:(SCNPlane*)givenSegment MaterialWithName:(NSString*)givenImageName{

    if((nil != givenSegment.materials) && ([givenSegment.materials count] != 0)){
        SCNMaterial *currentMaterial = [givenSegment.materials objectAtIndex:0];
        
        //nil the existing material
        currentMaterial.diffuse.contents = nil;
        givenSegment.materials = nil;
        
        //set new material
        [DigitNode giveSegment:givenSegment MaterialWithName:givenImageName];
    }
    else{
        SCNMaterial *material = [SCNMaterial material];
        material.diffuse.contents  = [textures objectForKey:givenImageName];
        material.shininess = 1.0;
        givenSegment.materials = @[material];
    }
}

@end
