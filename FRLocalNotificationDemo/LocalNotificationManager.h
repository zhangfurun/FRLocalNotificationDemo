//
//  LocalNotificationManager.h
//  FRLocalNotificationDemo
//
//  Created by 张福润 on 16/9/1.
//  Copyright © 2016年 张福润. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface LocalNotificationManager : NSObject
+ (LocalNotificationManager *)shareMG;

+ (void)registLocalNotification;
+ (void)setLocalNotificationWithAlertBody:(NSString *)alertBody alertTime:(NSInteger)alertTime noticeStr:(NSString *)str;
+ (void)cancelLocalNotificationWithKey:(NSString *)key;
@end
