//
//  ViewController.m
//  TabieSectionTapView
//
//  Created by 小川竜太 on 2015/06/19.
//  Copyright (c) 2015年 Ryuta Ogawa. All rights reserved.
//

#import "ViewController.h"
#import "TableSectionTapVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *calenderButton;

@property (weak, nonatomic) IBOutlet UIButton *aButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calenderButton.layer.cornerRadius = 10;
    self.calenderButton.layer.borderWidth = 1;
    self.calenderButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)buttonTap:(id)sender {
    TableSectionTapVC *vc = [[TableSectionTapVC alloc] initWithNibName:@"TableSectionTapVC" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
