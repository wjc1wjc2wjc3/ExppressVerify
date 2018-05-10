//
//  Global.h
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LBXScan/LBXScanViewController.h>


@interface Global : NSObject

////当前选择的扫码库
@property (nonatomic, assign) SCANLIBRARYTYPE libraryType;
////当前选择的识别码制
@property (nonatomic, assign) SCANCODETYPE scanCodeType;

+ (instancetype)sharedManager;

//返回native选择的识别码的类型
- (NSString*)nativeCodeType;

- (NSString*)nativeCodeWithType:(SCANCODETYPE)type;

//返回SCANCODETYPE 类别数组
- (NSArray*)nativeTypes;


@end
