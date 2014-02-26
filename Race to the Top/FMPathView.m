//
//  FMPathView.m
//  Race to the Top
//
//  Created by Fredrick Myers on 2/26/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMPathView.h"
#import "FMMountainPath.h"

@implementation FMPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    for (UIBezierPath *path in [FMMountainPath mountainPathsForRect:self.bounds])
    {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}


@end
