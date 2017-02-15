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
//  ClockNode.h
//  ClockDemo
//
//  Created by Jonathan Salvador on 11/25/12.
//  Copyright (c) 2012 Jonathan Salvador. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "DigitNode.h"
#import "DigitFont.h"

@interface ClockNode : SCNNode{
    Boolean isMilitary;
    Boolean showSeconds;
    
    DigitNode *medianNode;
    DigitNode *hourTen_Node;
    DigitNode *hourOne_Node;
    DigitNode *minuteTen_Node;
    DigitNode *minuteOne_Node;
    DigitNode *secondTen_Node;
    DigitNode *secondOne_Node;
}

-(void)startClockWithMilitary:(Boolean)givenMilitaryFlag andWithSeconds:(Boolean)givenSecondsFlag;

@end
