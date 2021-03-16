//
//  ViewController.m
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "ViewController.h"

#import "LocalNotificationManager.h"

@interface ViewController ()
{
    NSInteger timeNumber;
}
@property (weak, nonatomic) IBOutlet UIButton *button;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)sendLocalNotification:(UIButton *)sender {
    timeNumber = 5;
    NSTimer * timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadTimeBtn:) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)reloadTimeBtn:(NSTimer *)sender {
    
    [self.button setTitle:[NSString stringWithFormat:@"%ld", timeNumber] forState:UIControlStateNormal];
    if (timeNumber < 0) {
        [self.button setTitle:[NSString stringWithFormat:@"完成"] forState:UIControlStateNormal];
        [sender invalidate];
        [LocalNotificationManager sendLocalNotificationWithTitle:@"爆炸啦" content:@"Boom!!沙卡拉卡"];
    }
    timeNumber--;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
