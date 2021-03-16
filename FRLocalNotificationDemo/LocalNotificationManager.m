//
//  LocalNotificationManager.m
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import "LocalNotificationManager.h"

#import <UserNotifications/UserNotifications.h>

NSString * const LocalNotification_18_35_Name = @"LocalNotification_18_35_Name";
static NSString * const LOCAL_NOTIFICAITON_19_35_STRING = @"快起床~~";

static LocalNotificationManager * shareManager = nil;

@implementation LocalNotificationManager

+ (NSDateComponents *)localNotificationComponents:(NSCalendar *)calender {
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [formatter dateFromString:@"2020-01-01 18:35:00"];
    
    NSDateComponents *dateComponents = [calender components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    return dateComponents;
}

+ (void)timingRegisterLocalNotification {
    // 重置通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // 晚上7:45的提醒
    if (@available(iOS 10.0, *)) {
        [self registerLocalNotification_iOS_10];
    } else {
        [self registerLocalNotification_iOS_8];
    }
}

+ (void)registerLocalNotification_iOS_10 {
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"无聊的App提醒";
    content.subtitle = @"";
    content.body = LOCAL_NOTIFICAITON_19_35_STRING;
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound];
    
    content.userInfo = @{LocalNotification_18_35_Name : @"AddLocalNotification"};
    
    //to set the fire date
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComponents = [self localNotificationComponents:calender];
    
    
    // 在 alertTime 后推送本地推送
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:YES];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:LocalNotification_18_35_Name
                                                                          content:content
                                                                          trigger:trigger];
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
    }];
}

+ (void)registerLocalNotification_iOS_8 {
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti == nil) {
        return;
    }
    
    [noti setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSCalendar *calender = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComponents = [self localNotificationComponents:calender];
    
    NSDate *fireDate = [calender dateFromComponents:dateComponents];
    noti.fireDate = fireDate;
    noti.repeatInterval = kCFCalendarUnitDay;
    
    noti.alertBody = [NSString stringWithFormat:LOCAL_NOTIFICAITON_19_35_STRING];
    noti.alertAction = @"无聊App";
    noti.soundName = UILocalNotificationDefaultSoundName;
    noti.applicationIconBadgeNumber = 1;
    noti.userInfo = @{LocalNotification_18_35_Name : @"AddLocalNotification"};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

+ (void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content {
    [self sendLocalNotificationWithTitle:title content:content alertTime:0];
}

+ (void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content alertTime:(NSInteger)alertTime  {
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    
    //设置出发通知的时间
    
    NSDate * date = [NSDate date];
    NSLog(@"---%@", date);
    localNotification.fireDate = date;
    
    // 设置时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    localNotification.repeatInterval = 0;
    
    // 设置通知的内容
    localNotification.alertBody = content;
    localNotification.applicationIconBadgeNumber = 1;
    // 通知时播放声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary * dic = [NSDictionary dictionaryWithObject:@"localNotification" forKey:@"localNotification"];
    localNotification.userInfo = dic;
 
    //注册
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark - **************** 移除本地通知，在不需要此通知时记得移除
+ (void)removeNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
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
