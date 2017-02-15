//
//  SCNPlane+FlipClock.m
//  FlipClock
//
//  Created by Jonathan Salvador on 11/4/16.
//  Copyright © 2016 Jonathan Salvador. All rights reserved.
//

#import "SCNPlane+FlipClock.h"
#import "DigitNodeImageGeneratorUtil.h"

@implementation SCNPlane (FlipClock)

- (void)applyMaterialWithName:(NSString*)givenImageName {
    
    if((nil != self.materials) && ([self.materials count] != 0)){
        
        [self clearMaterials];
        
        //set new material
        [self applyMaterialWithName:givenImageName];
    }
    else{
        SCNMaterial *material = [SCNMaterial material];
        material.diffuse.contents  = [[DigitNodeImageGeneratorUtil textures] objectForKey:givenImageName];
        material.shininess = 1.0;
        self.materials = @[material];
    }
}

- (void)clearMaterials {
    
    SCNMaterial *currentMaterial = [[self materials] objectAtIndex:0];
    currentMaterial.diffuse.contents = nil;
    currentMaterial = nil;
    self.materials = @[];
}

@end
