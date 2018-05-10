//
//  StatusBarUtils.m
//  HZBitApp
//
//  Created by Apple on 9/2/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "StatusBarUtils.h"

static CGFloat kStatusHeight = 0;

@implementation StatusBarUtils

+(CGFloat)getStatusHeight{
    
    if (kStatusHeight == 0) {
        CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
        kStatusHeight = rectStatus.size.height;
    }

    return kStatusHeight;
}

@end
