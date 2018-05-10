//
//  HZBitScanViewController.m
//  HZBitSmartLock
//
//  Created by Apple on 11/1/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "HZBitScanViewController.h"
#import "ExpressNaviViewController.h"
#import "HZBitAlertAction.h"
#import "ViewControllerUtils.h"

@interface HZBitScanViewController ()
{
    LBXScanResult *_scanResult;
    UILabel *_scannerLabel;
}

@end

@implementation HZBitScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cameraInvokeMsg = @"相机启动中";
    self.isNeedScanImage = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ExpressNaviViewController *naviVC = (ExpressNaviViewController *)self.navigationController;
    if (naviVC && naviVC.expressNavigationBar) {
        [naviVC showNavigationBar:YES title:@"扫一扫"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_scannerLabel) {

        UILabel *scannerLabel = [[UILabel alloc] init];
        scannerLabel.textAlignment = NSTextAlignmentCenter;
        [scannerLabel setTextColor:[UIColor whiteColor]];
        [scannerLabel setText:@"请条形码放入扫描框内"];
        scannerLabel.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 50);
        [self.view addSubview:scannerLabel];
        _scannerLabel = scannerLabel;
    }
}

#pragma mark 
#pragma mark - LBXScanViewControllerDelegate
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array {
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:@"没有扫描到数据"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString *strResult = scanResult.strScanned;
    _scanResult = scanResult;
    self.scanImage = scanResult.imgScanned;
    
    DLog(@"strResult %@ ", strResult);
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:@"没有扫描到数据"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    switch (self.dataType) {
        case eScannerNumber:
            {
                [self.navigationController popViewControllerAnimated:YES];
                if (_scannerDelegate && [_scannerDelegate respondsToSelector:@selector(scannerResult:)]) {
                    [_scannerDelegate scannerResult:strResult];
                }
            }
            break;
        default:
            break;
    }
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    ExpressWeakSelf();
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:strResult message:@"是否重启设备?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf reStartDevice];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
