//
//  ExpressViewController.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressViewController.h"
#import "DeviceUtils.h"

NSInteger const indicatorTag = 1000;

@interface ExpressViewController ()

@property (nonatomic, strong, readwrite) ExpressViewModel *viewModel;
@property (nonatomic, weak)UIActivityIndicatorView *indicatorView;
@property (nonatomic, weak)UIView *indicatorViewBg;

@end

@implementation ExpressViewController

- (ExpressViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)setSubViewsOffset:(BOOL)decrease {
    
    if (![DeviceUtils isiPhoneX]) {
        return;
    }
    
    NSArray *views = self.view.subviews;
    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *subView = (UIView *)obj;
        CGRect rect = subView.frame;
        CGFloat offHeight = decrease ? rect.size.height - iPhoneX_Bang_Height : rect.size.height;
        subView.frame = CGRectMake(rect.origin.x, rect.origin.y + iPhoneX_Bang_Height, rect.size.width, offHeight);
    }];
}

- (void)setSubViewOffset:(UIView *)offsetView decreaseHeight:(BOOL)decrease {
    
    if (![DeviceUtils isiPhoneX]) {
        return;
    }
    
    if (!offsetView) {
        return;
    }
    
    CGFloat bangHeight = iPhoneX_Bang_Height * 2;
    CGRect rect = offsetView.frame;
    CGFloat offHeight = decrease ? rect.size.height - bangHeight : rect.size.height;
    offsetView.frame = CGRectMake(rect.origin.x, rect.origin.y + bangHeight, rect.size.width, offHeight);
}

- (void)adjustTopWhiteZone:(UITableView *)tableView {
    if (!tableView) {
        return;
    }
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = NO;
    } else {
        // Fallback on earlier versions
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)showIndicator:(BOOL)bHiddenOther {
    if (!_indicatorView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.tag = indicatorTag;
        [view setBackgroundColor:ARGB(0, 0, 0, 0.5)];
        [self.view addSubview:view];
        _indicatorViewBg = view;
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.frame = CGRectMake(0, 0, 60, 60);
        [indicatorView setCenter:CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5)];
        [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        CGAffineTransform transform = CGAffineTransformMakeScale(2.5, 2.5);
        indicatorView.transform = transform;
        [_indicatorViewBg addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    if (bHiddenOther) {
        NSArray *views = [self.view subviews];
        for (UIView *view in views) {
            NSInteger tag = view.tag;
            if (tag != indicatorTag) {
                [view setHidden:YES];
            }
        }
    }
    
    [_indicatorView setHidden:NO];
    [_indicatorView startAnimating];
    
}

- (void)hiddenIndicator:(BOOL)bHiddenOther {
    NSArray *views = [self.view subviews];
    for (UIView *view in views) {
        if (view.tag == indicatorTag) {
            [_indicatorView stopAnimating];
            [_indicatorView removeFromSuperview];
            _indicatorView = nil;
            
            [_indicatorViewBg removeFromSuperview];
            _indicatorViewBg = nil;
        }
        else
        {
            if (bHiddenOther) {
                [view setHidden:NO];
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)hideNaviBar {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(ExpressNaviViewController *)naviVC hideNavigationBar];
    }
}

- (void)showNaviBar:(NSString *)title {
    [self showNaviBar:YES title:title];
}

- (void)showNaviBar:(BOOL)bShowBack title:(NSString *)title {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(ExpressNaviViewController *)naviVC showNavigationBar:bShowBack title:title];
    }
}

- (void)showRightLeftNaviBar:(BOOL)bShowBack title:(NSString *)title right:(NSString *)rightTitle {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(ExpressNaviViewController *)naviVC showNavigationBar:bShowBack title:title right:rightTitle];
    }
}

- (void)setNavibarBlock:(naviBackBlock)block {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(ExpressNaviViewController *)naviVC setBackBlock:block];
    }
}

- (void)setNavibarRightBlock:(naviRightBlock)block {
    UINavigationController *naviVC = self.navigationController;
    if (naviVC) {
        [(ExpressNaviViewController *)naviVC setRightBlock:block];
    }
}

- (void)pushViewController:(UIViewController *)viewController {
    if (_delegate && [_delegate respondsToSelector:@selector(pushViewController:)]) {
        [_delegate pushViewController:viewController];
    }
}

- (void)popBackMain {
    if (_delegate && [_delegate respondsToSelector:@selector(popBackMain)]) {
        [_delegate popBackMain];
    }
}


@end
