//
//  HZBitScanPermissions.h
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZBitScanPermissions : NSObject

+ (BOOL)cameraPemission;

+ (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion;

+ (BOOL)photoPermission;

@end
