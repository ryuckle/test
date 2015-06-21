//
//  SessionViewController.m
//  TabieSectionTapView
//
//  Created by 小川竜太 on 2015/06/20.
//  Copyright (c) 2015年 Ryuta Ogawa. All rights reserved.
//

#import "SessionViewController.h"

@interface SessionViewController ()

@property (weak, nonatomic) IBOutlet UINavigationBar *navibar;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@end

@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.aLabel setText:[NSString stringWithFormat: @"セッション%ld", _sessionNum]];
    UIBarButtonItem *backBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
    [self.navibar.backItem setBackBarButtonItem:backBarButtonItem];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
