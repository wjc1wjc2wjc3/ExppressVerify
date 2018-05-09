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

static NSURLSessionDataTask * extracted(NSDictionary *dict, FindExpressViewModel *viewModel) {
    return [viewModel startRequest:dict token:@""];
}

- (IBAction)verifyAction:(id)sender {
    NSString *numbers = self.expressTF.text;
    if ([@"" isEqualToString:numbers]) {
        [MBManager showBriefAlert:@"快递单号不能为空"];
        return;
    }
    
    FindExpressModel *model = [[FindExpressModel alloc] init];
    model.numbers = numbers;
    NSDictionary *dict = [model dictionary];
    
    FindExpressViewModel *viewModel = [[FindExpressViewModel alloc] init];
    viewModel.bitSuccessBlock = ^(ExpressViewModel *returnValue) {
        
    };
    [viewModel startRequest:dict token:@""];
    
}

#pragma mark
#pragma mark - HZBitScannerViewDelegate
- (void) scannerResult:(NSString *)data {
    if (data) {
        self.expressTF.text = data;
    }
}

@end
