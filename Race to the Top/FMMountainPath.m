//
//  FMMountainPath.m
//  Race to the Top
//
//  Created by Fredrick Myers on 2/26/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMMountainPath.h"

@implementation FMMountainPath

+ (NSArray *)mountainPathsForRect:(CGRect)rect
{
    NSMutableArray *variousPaths = [@[] mutableCopy];
    CGPoint firstPoint = CGPointMake(rect.size.width * (1/6.0), CGRectGetMaxY(rect));
    CGPoint secondPoint = CGPointMake(rect.size.width * (1/3.0), rect.size.height * (5/6.0));
    
    UIBezierPath *labyrinthPath = [UIBezierPath bezierPath];
    labyrinthPath.lineWidth = 4.0;
    [labyrinthPath moveToPoint:firstPoint];
    [labyrinthPath addLineToPoint:secondPoint];
    
    [variousPaths addObject:labyrinthPath];
    
    return variousPaths;
}

@end
