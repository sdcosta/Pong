//
//  ViewController.m
//  Pong
//
//  Created by Shouvik D'Costa on 12/9/2013.
//  Copyright (c) 2013 Shouvik D'Costa. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)computerMovement:(NSTimer*) localTimer
{
    //if the ball is to the right of the computer
    if(ball.center.x >= computer.center.x)
    {
        //set computer to follow the ball
        computer.center = CGPointMake(computer.center.x + 1, computer.center.y);
    }
    //if the ball is to the left of the computer
    if(ball.center.x <= computer.center.x)
    {
        //set computer to follow the ball
        computer.center = CGPointMake(computer.center.x - 1, computer.center.y);
    }
    
    //set the bounds of the computer in the x-direction
    if(computer.center.x < 30)
    {
        computer.center = CGPointMake(30, computer.center.y);
    }
    
    if(computer.center.x > 290)
    {
        computer.center = CGPointMake(290, computer.center.y);
    }
}

- (IBAction)startButton:(id)sender
{
    //Initially set the x & y coordinates
    if(x == 0 && y == 0){
        x = 1;
        y = 1;
        //Initialize the ball
        ball.center = CGPointMake(160, 240);
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(ballMovement:) userInfo:nil repeats:YES];

    
    startButton.alpha = 0;
    playerScore.alpha = 0;
    computerScore.alpha = 0;
    playerLabel.alpha = 0;
    computerLabel.alpha = 0;
    
}

- (void)ballMovement:(NSTimer*) localTimer
{
    //if the ball is hits the edge of the screen then change direction of the ball
    //in the x-direction
    if(ball.center.x == 315 || ball.center.x == 10)
    {
        x *= -1;
    }
    //if the ball hits the computer then change the direction of the ball
    //in the y-direction
    if(ball.center.y == 54)
    {
        if((ball.center.x <= (computer.center.x + 60)) && ball.center.x >= computer.center.x)
        {
            y *= -1;
        }
    }
    //set the movement of the ball
    ball.center = CGPointMake(ball.center.x + x, ball.center.y + y);
    
    //If the ball is the same height as the paddle
    if(ball.center.y == 428)
    {
        //Check whether the paddle is directly under the ball
        //If it is then allow the ball to bounce back up
        if((((CATextLayer*)paddle.layer.presentationLayer).frame.origin.x + 60) >= ball.center.x &&
           ((CATextLayer*)paddle.layer.presentationLayer).frame.origin.x <= ball.center.x)
        {
            y *= -1;
        }
    }
    
    //Call the computerMovement method
    [self computerMovement:localTimer];
    
    //end the ball movement when the player loses a point
    if(ball.center.y == 490)
    {
        [localTimer invalidate];
        //Initialize the ball
        ball.center = CGPointMake(160, 240);
        //reset the coordinates
        x = 0;
        y = 0;
        
        int score = [computerScore.text intValue] + 1;
        //Set the new computer score
        computerScore.text = [NSString stringWithFormat:@"%i",score];
        
        //Display all hidden objects
        startButton.alpha = 1;
        playerScore.alpha = 1;
        computerScore.alpha = 1;
        playerLabel.alpha = 1;
        computerLabel.alpha = 1;
    }
    //end the ball movement when the computer loses a point
    if(ball.center.y == 10)
    {
        [localTimer invalidate];
        //Initialize the ball
        ball.center = CGPointMake(160, 240);
        //reset the coordinates
        x = 0;
        y = 0;
        
        int score = [playerScore.text intValue] + 1;
        //Set the new player value
        playerScore.text = [NSString stringWithFormat:@"%i", score];
        
        //Display all hidden objects
        startButton.alpha = 1;
        playerScore.alpha = 1;
        computerScore.alpha = 1;
        playerLabel.alpha = 1;
        computerLabel.alpha = 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[event allTouches]count] > 1)
    {
        [timer invalidate];
        
        //Display all hidden objects
        startButton.alpha = 1;
        playerScore.alpha = 1;
        computerScore.alpha = 1;
        playerLabel.alpha = 1;
        computerLabel.alpha = 1;
    }
    
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    CGPoint point = [touch locationInView:self.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        paddle.center = CGPointMake(point.x, 440);
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // Get the specific point that was touched
    CGPoint point = [touch locationInView:self.view];
    
    //set the paddle's center to go in the x direction of the point touched
    paddle.center = CGPointMake(point.x, 440);
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
