//
//  ExpressNaviViewController.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressNaviViewController.h"
#import "UIImage+Express.h"
#import "ExpressNavigationBar.h"
#import "StatusBarUtils.h"

typedef NS_OPTIONS(NSUInteger, NaviType) {
    eBackType = 1 << 0,
    eMenu = 1 << 1,
};

@interface ExpressNaviViewController ()<ExpressNavigationBarDelegate>

@property (nonatomic, assign) NaviType naviType;

@end

@implementation ExpressNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar removeFromSuperview];
    
    _expressNavigationBar = [self addNavigaBar:@"icon_back"];
    self.naviType = eBackType;
}

- (ExpressNavigationBar *)addNavigaBar:(NSString *)leftImageName {
    CGFloat statusBarHeight = [StatusBarUtils getStatusHeight];
    CGFloat startY = 0;
    CGFloat navigationHeight = statusBarHeight;
    if (@available(iOS 11.0, *)) {
        startY = statusBarHeight;
        navigationHeight = 0;
    }
    ExpressNavigationBar *expressNavigationBar = [[ExpressNavigationBar alloc] initWithFrame:CGRectMake(0, startY, kScreenWidth, NAVIGATIONBAR_HEIGHT + navigationHeight) image:leftImageName];
    expressNavigationBar.exDelegate = self;
    [self.view addSubview:expressNavigationBar];
    
    return expressNavigationBar;
}

- (void)hideNavigationBar {
    if (_expressNavigationBar) {
        [_expressNavigationBar setHidden:YES];
    }
}

- (void)addMenuBar {
    if (self.naviType == eMenu) {
        return;
    }
    
    if (_expressNavigationBar) {
        [_expressNavigationBar removeFromSuperview];
        _expressNavigationBar = nil;
    }
    self.naviType = eMenu;
    _expressNavigationBar = [self addNavigaBar:@"collect_list_menu"];
}

- (void)addBackBar {
    if (self.naviType == eBackType) {
        return;
    }
    
    
    if (_expressNavigationBar) {
        [_expressNavigationBar removeFromSuperview];
        _expressNavigationBar = nil;
    }
    self.naviType = eBackType;
    _expressNavigationBar = [self addNavigaBar:@"icon_back"];
}

- (void)remnoveNavigationBar {
    if (_expressNavigationBar) {
        [_expressNavigationBar removeFromSuperview];
    }
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    if (_expressNavigationBar) {
        [_expressNavigationBar setNaviBackgroundColor:color];
    }
}

- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title {
    if (_expressNavigationBar) {
        [_expressNavigationBar setHidden:NO];
        [_expressNavigationBar setShowBackItem:bShowBack title:title];
    }
}

- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title right:(NSString *)rightTitle {
    if (_expressNavigationBar) {
        [_expressNavigationBar setHidden:NO];
        [_expressNavigationBar setShowRightLeft:bShowBack title:title right:rightTitle];
    }
}

#pragma HZBitNavigationBarDelegate
- (void)backItem {
    switch (self.naviType) {
        case eBackType:
        {
            if (_backBlock) {
                _backBlock();
                _backBlock = nil;
            }
            else
            {
                [self popViewControllerAnimated:YES];
            }
        }
            break;
            
        case eMenu:
        {
            if (_backBlock) {
                _backBlock();
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)rightItem {
    if (self.rightBlock) {
        self.rightBlock();
    }
}


@end
