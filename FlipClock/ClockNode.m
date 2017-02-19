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
//  ClockNode.m
//  ClockDemo
//
//  Created by Jonathan Salvador on 11/25/12.
//  Copyright (c) 2012 Jonathan Salvador. All rights reserved.
//

#import "ClockNode.h"

@implementation ClockNode

//date of time currently being displayed
NSDate *displayedDate;
CGFloat DigitGap = 0.5;
CGFloat currentLateral;

- (void)startClockWithMilitary:(Boolean)givenMilitaryFlag andWithSeconds:(Boolean)givenSecondsFlag {
    
    currentLateral = 0.0;
    
    isMilitary  = givenMilitaryFlag;
    showSeconds = givenSecondsFlag;
    
    //set initial time
    displayedDate = [NSDate dateWithTimeIntervalSinceNow:0];
    
    //define first node
    medianNode   = (DigitNode*)[DigitNode node];
    
    //define DigitNodes
    hourTen_Node   = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth];
    CATransform3D trans_hourTen = CATransform3DMakeTranslation(currentLateral, 0, 0); //move to the right
    hourTen_Node.transform = trans_hourTen;
    
    hourOne_Node   = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth];
    CATransform3D trans_hourOne = CATransform3DMakeTranslation(currentLateral + DigitGap, 0, 0); //move to the right
    hourOne_Node.transform = trans_hourOne;    
    
    minuteTen_Node = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth] + (4.0 * DigitGap);
    CATransform3D trans_minuteTen = CATransform3DMakeTranslation(currentLateral, 0, 0); //move to the right
    minuteTen_Node.transform = trans_minuteTen;
    
    minuteOne_Node = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth];
    CATransform3D trans_minuteOne = CATransform3DMakeTranslation(currentLateral + DigitGap, 0, 0); //move to the right
    minuteOne_Node.transform = trans_minuteOne;
    
    secondTen_Node = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth] + (4.0 * DigitGap);
    CATransform3D trans_secondTen = CATransform3DMakeTranslation(currentLateral, 0, 0); //move to the right
    secondTen_Node.transform = trans_secondTen;
    
    secondOne_Node = (DigitNode*)[DigitNode node];
    currentLateral += [DigitNode getDigitWidth];
    CATransform3D trans_secondOne = CATransform3DMakeTranslation(currentLateral + DigitGap, 0, 0); //move to the right
    secondOne_Node.transform = trans_secondOne;
    
    //add median node
    if(!isMilitary)
        [self addChildNode:medianNode];
    
    [self addChildNode:hourTen_Node];
    [self addChildNode:hourOne_Node];
    [self addChildNode:minuteTen_Node];
    [self addChildNode:minuteOne_Node];
    //add seconds
    if(showSeconds) {
        [self addChildNode:secondTen_Node];
        [self addChildNode:secondOne_Node];
    }
    
    //start nodes at current time
    [medianNode     startDigitAt:[self getCurrentMedian]];
    [hourTen_Node   startDigitAt:[self getHourTen]];
    [hourOne_Node   startDigitAt:([self getHour] % 10)];
    [minuteTen_Node startDigitAt:[self getMinuteTen]];
    [minuteOne_Node startDigitAt:([self getMinute] % 10)];
    if(showSeconds) {
        [secondTen_Node startDigitAt:[self getSecondTen]];
        [secondOne_Node startDigitAt:([self getSecond] % 10)];
    }
    
    [self flipToCurrentTime];
//    Begin timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(flipToCurrentTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)flipToCurrentTime{
    
    //set current time to displayedTime
    displayedDate = [NSDate dateWithTimeIntervalSinceNow:0];
//    displayedDate = [NSDate dateWithTimeInterval:1.0 sinceDate:displayedDate];
    
    //send flip commands to appropriate DigitNodes
    [medianNode     flipToDigit:[self getCurrentMedian]];
    [hourTen_Node   flipToDigit:[self getHourTen]];
    [hourOne_Node   flipToDigit:([self getHour] % 10)];
    [minuteTen_Node flipToDigit:[self getMinuteTen]];
    [minuteOne_Node flipToDigit:([self getMinute] % 10)];
    if(showSeconds) {
        [secondTen_Node flipToDigit:[self getSecondTen]];
        [secondOne_Node flipToDigit:([self getSecond] % 10)];
    }
}

-(DigitType)getCurrentMedian{
    if([ClockNode isAM])
        return kAM;
    else
        return kPM;
}

+(BOOL)isAM{
    return ([[ClockNode getDateComponents] hour] < 12);
}

#pragma mark - Tens Place Digits

-(NSInteger)getSecondTen{
    return ([self getSecond] / 10);
}

-(NSInteger)getHourTen{
    return ([self getHour] / 10);
}

-(NSInteger)getMinuteTen{
    return ([self getMinute] / 10);
}

-(NSInteger)getHour{
    
    NSInteger currentHour = [[ClockNode getDateComponents] hour];
    if(isMilitary){ //24hr clock
        return currentHour;
    }
    else{ // AM_PM clock
        
        if(currentHour == 0)
            return 12;
        else if(currentHour > 12)
            return currentHour - 12;
        else
            return currentHour;
    }
}

#pragma mark - Date Component Queries

-(NSInteger)getMinute{
    return [[ClockNode getDateComponents] minute];
}

-(NSInteger)getSecond{
    return [[ClockNode getDateComponents] second];
}

//gets date components for current date
+(NSDateComponents*)getDateComponents{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit  | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:displayedDate];
    
    return components;
}

@end
