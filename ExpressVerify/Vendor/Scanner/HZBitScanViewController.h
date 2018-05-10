//
//  HZBitScanViewController.h
//  HZBitSmartLock
//
//  Created by Apple on 11/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import <LBXScan/LBXScanViewController.h>

typedef NS_ENUM(NSUInteger, DataQrCodeType) {
    eScannerNumber = 1,
};

@protocol HZBitScannerViewDelegate <NSObject>

@optional
- (void) scannerResult:(NSString *)data;

@end

@interface HZBitScanViewController : LBXScanViewController

@property (nonatomic, assign) DataQrCodeType dataType;
@property (nonatomic, weak) id<HZBitScannerViewDelegate> scannerDelegate;

@end
