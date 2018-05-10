//
//  NSDate+Express.h
//  Express
//
//  Created by Apple on 14/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Express)

+ (NSString *)dateFromTime:(NSString *)time;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringFromDates:(NSDate *)date;
+ (NSString *)stringFromDateSecond:(NSDate *)date;
+ (BOOL)isSameDay:(NSString *)currentDate compare:(NSString *)date;
@end
