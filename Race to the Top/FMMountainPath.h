//
//  FMMountainPath.h
//  Race to the Top
//
//  Created by Fredrick Myers on 2/26/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMMountainPath : NSObject

+ (NSArray *)mountainPathsForRect:(CGRect)rect;
+ (UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;

@end
