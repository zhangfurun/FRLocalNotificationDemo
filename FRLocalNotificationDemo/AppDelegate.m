//
//  AppDelegate.m
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalNotificationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //清空提醒的个数
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //获取通知信息
    NSString * messageNoti = [notification.userInfo objectForKey:@"localNotification"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"爆炸啦"
                                                    message:messageNoti
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // 在不需要再推送时，可以取消推送
    [LocalNotificationManager cancelLocalNotificationWithKey:@"key"];
}

@end
