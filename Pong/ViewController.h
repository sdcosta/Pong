//
//  ViewController.h
//  Pong
//
//  Created by Shouvik D'Costa on 12/9/2013.
//  Copyright (c) 2013 Shouvik D'Costa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *paddle;
    IBOutlet UIImageView *ball;
    IBOutlet UIView *gameView;
    IBOutlet UIButton *startButton;
    IBOutlet UILabel *computer;
    
    IBOutlet UILabel *playerScore;
    IBOutlet UILabel *computerScore;
    
    IBOutlet UILabel *playerLabel;
    IBOutlet UILabel *computerLabel;
    NSTimer* timer;
    
    float x;
    float y;
}

- (void)ballMovement:(NSTimer*)timer;
- (IBAction)startButton:(id)sender;

@end

