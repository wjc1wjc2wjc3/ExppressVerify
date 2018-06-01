//
//  ViewController.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ViewController.h"
#import "FindExpressModel.h"
#import "FindExpressViewModel.h"
#import "HZBitScanViewController.h"
#import "Global.h"
#import "HZBitScanStyle.h"
#import "FindExpressData.h"
#import "NSDate+Express.h"

@interface ViewController ()<HZBitScannerViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *expressTF;
@property (nonatomic, weak) IBOutlet UIButton *scanBtn;
@property (nonatomic, weak) IBOutlet UIButton *verifyBtn;
@property (nonatomic, weak) IBOutlet UITextView *verifyResultTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showNaviBar:NO title:@"寄递哥核验"];
    
}

- (IBAction)ocrAction:(id)sender {
    HZBitScanViewController *hzBitScannVC = [[HZBitScanViewController alloc] init];
    hzBitScannVC.style = [HZBitScanStyle weixinStyle];
    hzBitScannVC.isOpenInterestRect = YES;
    hzBitScannVC.libraryType = [Global sharedManager].libraryType;
    hzBitScannVC.scanCodeType = [Global sharedManager].scanCodeType;
    hzBitScannVC.hidesBottomBarWhenPushed = YES;
    hzBitScannVC.dataType = eScannerNumber;
    hzBitScannVC.scannerDelegate = self;
    [self.navigationController pushViewController:hzBitScannVC animated:YES];
}


- (IBAction)verifyAction:(id)sender {
    NSString *numbers = self.expressTF.text;
    if ([@"" isEqualToString:numbers]) {
        [MBManager showBriefAlert:@"快递单号不能为空"];
        return;
    }
    
    [self.expressTF resignFirstResponder];
    self.verifyResultTV.text = @"";
    [self startFind:numbers city:YES];
}

- (void)startFind:(NSString *)numbers city:(BOOL)bCity {
    
    FindExpressModel *model = [[FindExpressModel alloc] init];
    model.numbers = numbers;
    NSDictionary *dict = [model dictionary];
    
    ExpressWeakSelf();
    FindExpressViewModel *viewModel = [[FindExpressViewModel alloc] init];
    viewModel.bCity = bCity;
    viewModel.bitSuccessBlock = ^(ExpressViewModel *returnValue) {
        FindExpressViewModel *vm = (FindExpressViewModel *)returnValue;
        [weakSelf showNumbers:vm.findExpressData];
    };
    __block FindExpressViewModel *vm = viewModel;
    viewModel.bitFailureBlock = ^(ExpressViewModel *errorCode) {
        if (vm.bCity) {
            [weakSelf startFind:numbers city:NO];
        }
        else
        {
            [MBManager showBriefAlert:@"没有此快递单号的信息"];
        }
    };
    [viewModel startRequest:dict];
    
}

- (void)showNumbers:(FindExpressData *)data {
    if (!data) {
        return;
    }
    
    NSMutableString *result = [NSMutableString stringWithString:@"核验结果:\n"];
    [result appendString:@"\t该快递已于"];
    long long time = data.createDate.longLongValue / 1000;
    NSString *timeStr = [NSString stringWithFormat:@"%lld", time];
    [result appendFormat:@"%@", [NSDate dateFromTime:timeStr]];
    [result appendString:@"实名比对"];
//    result = [result stringByAppendingFormat:@"寄件人区: %@\n", data.divisionName];
//    result = [result stringByAppendingFormat:@"寄件人地址: %@\n", data.policeStationName];
//    result = [result stringByAppendingFormat:@"快递单号: %@\n", data.expressNumber];
//    result = [result stringByAppendingFormat:@"寄件人号码: %@\n", data.phoneNumber];
//    result = [result stringByAppendingFormat:@"收件人号码: %@\n", data.receiverMobilephone];
//    result = [result stringByAppendingFormat:@"收件人省 :%@\n", data.province];
//    result = [result stringByAppendingFormat:@"收件人城市 :%@\n", data.city];
//    result = [result stringByAppendingFormat:@"收件人区 :%@\n", data.county];
//    result = [result stringByAppendingFormat:@"收件人街道 :%@\n", data.street];
//    result = [result stringByAppendingFormat:@"收件人地址 :%@\n", data.address];

    self.verifyResultTV.text = result;
}

#pragma mark
#pragma mark - HZBitScannerViewDelegate
- (void) scannerResult:(NSString *)data {
    if (data) {
        self.expressTF.text = data;
    }
}

@end
