//
//  ViewController.m
//  TouchPoint
//
//  Created by 小川竜太 on 2014/05/11.
//  Copyright (c) 2014年 Ryuta Ogawa. All rights reserved.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    NSLog(@"x:%lf y:%lf", pt.x, pt.y);
    
}



@end
