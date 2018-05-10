//
//  DeviceUtils.m
//  HZBitSmartLock
//
//  Created by Apple on 23/01/2018.
//  Copyright © 2018 HZBit. All rights reserved.
//

#import "DeviceUtils.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import "NSString+Express.h"

//系统版本
static NSString *version = @"";

//品牌
static NSString *model = @"";

//idfa
static NSString *idfaLocal = @"";
static NSString *idfaLocalPureString = @"";
//systemName
static NSString *systemName = @"";

//name
static NSString *name = @"";

static NSString *deviceModel = @"";

static NSString *iPhoneX = @"";

@implementation DeviceUtils

+(NSString *)systemVersion {
    if ([@"" isEqualToString:version]) {
        version = [[UIDevice currentDevice] systemVersion];
    }
    
    return version;
}

+(NSString *)localizedModel {
    if ([@"" isEqualToString:model]) {
        model = [[UIDevice currentDevice] localizedModel];
    }
    
    return model;
}

+ (NSString *)idfaString {
    if ([idfaLocal isEqualToString:@""]) {
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        idfaLocal = idfa;
    }
    
    return idfaLocal;
}

+ (NSString *)idfaStringHash {
    if ([idfaLocalPureString isEqualToString:@""]) {
        NSString *idfaString = [self idfaString];
        idfaLocalPureString = [idfaString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return idfaLocalPureString;
}

+ (NSString *)systemName {

    if ([systemName isEqualToString:@""]) {
         systemName = [[UIDevice currentDevice] systemName];
    }
    
    return systemName;
}

+ (NSString *)localizedName {
    if ([name isEqualToString:@""]) {
        name = [[UIDevice currentDevice] name];
    }
    
    return name;
}

+ (NSString *)iPhoneType
{

    if ([@"" isEqualToString:deviceModel]) {
        struct utsname systemInfo;
        uname(&systemInfo);
        deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    return deviceModel;
}

+ (BOOL )isiPhoneX {
    NSString *deviceModel  = [self iPhoneType];
    if ([@"" isEqualToString:iPhoneX]) {
        if ([deviceModel hasPrefix:@"x86_64"] ||
            [deviceModel hasPrefix:@"iPhone10"]) {
            iPhoneX = @"1";
        }
        else
        {
            iPhoneX = @"0";
        }
    }
    
    return [iPhoneX isEqualToString:@"1"];
}

@end
