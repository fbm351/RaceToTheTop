//
//  FMViewController.m
//  Race to the Top
//
//  Created by Fredrick Myers on 2/26/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMViewController.h"
#import "FMPathView.h"
#import "FMMountainPath.h"

#define FMMAP_STARTING_SCORE 15000
#define FMMAP_SCORE_DECREMENT_AMOUNT 100
#define FMTIMER_INTERVAL 0.1
#define FMWALL_PENALTY 500

@interface FMViewController ()

@property (strong, nonatomic) IBOutlet FMPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;


@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapRecognizer.numberOfTapsRequired = 2;
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"Tapped!");
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"Tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    if(panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:FMTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %i", FMMAP_STARTING_SCORE];
    }
    
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        for (UIBezierPath *path in [FMMountainPath mountainPathsForRect:self.pathView.bounds])
        {
            UIBezierPath *tapTarget = [FMMountainPath tapTargetForPath:path];
            
            if ([tapTarget containsPoint:fingerLocation]) {
                [self decrementScoreByAmount:FMWALL_PENALTY];
            }
        }
    }
    
    else if (panRecognizer.state == UIGestureRecognizerStateEnded  && fingerLocation.y <= 165)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You fell off the mountain.  Go back to the beginning and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        [self.timer invalidate];
        self.timer = nil;
    }
    
    

}

- (void)timerFired
{
    [self decrementScoreByAmount:FMMAP_SCORE_DECREMENT_AMOUNT];
}

- (void)decrementScoreByAmount:(int)ammount
{
    NSString *scoreText = [[self.scoreLable.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score = score - ammount;
    
    self.scoreLable.text = [NSString stringWithFormat:@"Score: %i", score];
}

@end
