//
//  NSDate+Express.m
//  Express
//
//  Created by Apple on 14/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import "NSDate+Express.h"

@implementation NSDate (Express)


+ (NSString *)dateFromTime:(NSString *)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    return [self stringFromDates:date];
}


+ (NSString *)stringFromDate:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)stringFromDates:(NSDate *)date
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy:MM:dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)stringFromDateSecond:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy:MM:dd HH:MM:SS"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

/**
 @decription 判断当前的两个日期是否为同一天
 */
+ (BOOL)isSameDay:(NSString *)currentDate compare:(NSString *)date {
    __block BOOL bSame = NO;
    NSArray<NSString *> *currentArray = [currentDate componentsSeparatedByString:@":"];
    NSArray<NSString *> *array = [date componentsSeparatedByString:@":"];
    if (currentArray.count != 3 || array.count != 3 || currentArray.count != array.count) {
        return bSame;
    }
    
    bSame = YES;
    [currentArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.integerValue != array[idx].integerValue) {
            *stop = YES;
            bSame = NO;
        }
    }];
    return bSame;
}

@end
