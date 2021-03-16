//
//  LocalNotificationManager.h
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

extern NSString * const LocalNotification_18_35_Name;

@interface LocalNotificationManager : NSObject
// 开启定时推送
+ (void)timingRegisterLocalNotification;

// 发送及时推送
+ (void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content;

// 发送延迟推送
+ (void)sendLocalNotificationWithTitle:(NSString *)title content:(NSString *)content alertTime:(NSInteger)alertTime;

// 取消推送
+ (void)removeNotification;
+ (void)cancelLocalNotificationWithKey:(NSString *)key;
@end
