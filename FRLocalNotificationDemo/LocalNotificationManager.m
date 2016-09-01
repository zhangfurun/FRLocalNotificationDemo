//
//  LocalNotificationManager.m
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "LocalNotificationManager.h"

static LocalNotificationManager * shareManager = nil;

@implementation LocalNotificationManager

+ (LocalNotificationManager *)shareMG {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[LocalNotificationManager alloc]init];
    });
    return shareManager;
}

+ (void)registLocalNotification {
    UILocalNotification * localNotif = [[UILocalNotification alloc]init];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        localNotif.repeatInterval = NSCalendarUnitDay;
    }
    else {
        localNotif.repeatInterval = NSDayCalendarUnit;
    }
}

+ (void)setLocalNotificationWithAlertBody:(NSString *)alertBody alertTime:(NSInteger)alertTime noticeStr:(NSString *)str {
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    
    //设置出发通知的时间
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"---%@", date);
    localNotification.fireDate = date;
    
    // 设置时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    localNotification.repeatInterval = kCFCalendarUnitSecond;
    
    // 设置通知的内容
    localNotification.alertBody = alertBody;
    localNotification.applicationIconBadgeNumber = 1;
    // 通知时播放声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary * dic = [NSDictionary dictionaryWithObject:str forKey:@"localNotification"];
    localNotification.userInfo = dic;
    
    //注册
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    NSArray * arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification * locaNotification in arr) {
        if (locaNotification.userInfo) {
            NSString * str = locaNotification.userInfo[key];
            if (str) {
                [[UIApplication sharedApplication] cancelLocalNotification:locaNotification];
            }
        }
    }
}

@end
