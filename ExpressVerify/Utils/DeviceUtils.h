//
//  DeviceUtils.h
//  HZBitSmartLock
//
//  Created by Apple on 23/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceUtils : NSObject

+ (NSString *)systemVersion;
+ (NSString *)localizedModel;
+ (NSString *)idfaString;
+ (NSString *)idfaStringHash;
+ (NSString *)localizedName;
+ (NSString *)systemName;
+ (NSString *)iPhoneType;
+ (BOOL )isiPhoneX;
@end
