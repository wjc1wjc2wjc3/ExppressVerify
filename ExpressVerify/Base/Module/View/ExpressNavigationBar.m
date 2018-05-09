//
//  ExpressNavigationBar.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressNavigationBar.h"
#import "UIImage+Express.h"


@implementation ExpressNavigationBar {
    UIButton *_backButton;
    UIButton *_rightButton;
}

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)leftImageName{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *image = [UIImage createImageWithColor:MainColor];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *attributeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0],NSFontAttributeName, nil];
        self.titleTextAttributes = attributeDictionary;
        
        [self addBackItemImage:leftImageName];
        
    }
    return self;
}

- (void)addBackItemImage:(NSString *)leftImageName{
    UIImage *backImage = [UIImage imageNamed:leftImageName];
    CGSize backImageSize = backImage.size;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backImageSize.width * 2, backImageSize.height)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItem:) forControlEvents:UIControlEventTouchUpInside];
    _backButton = backButton;
    UIBarButtonItem *leftNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - backImageSize.width * 2, 0, backImageSize.width * 2, backImageSize.height)];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton = rightButton;
    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.leftItemsSupplementBackButton = YES;
    [navigationItem setLeftBarButtonItem:leftNavigationItem];
    [navigationItem setRightBarButtonItem:rightNavigationItem];
    [self pushNavigationItem:navigationItem animated:NO];
    self.navigationItem = navigationItem;
}

- (void)addRightItemButton:(UIButton *)button {
    
    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    [navigationItem setRightBarButtonItem:rightNavigationItem];
    [self pushNavigationItem:navigationItem animated:NO];
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    self.barStyle = UIBarStyleBlackTranslucent;
    UIImage *image = [UIImage createImageWithColor:color];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)backItem:(UIButton *)button {
    if (_exDelegate && [_exDelegate respondsToSelector:@selector(backItem)]) {
        [_exDelegate backItem];
    }
}

- (IBAction)rightAction:(UIButton *)button {
    if (_exDelegate && [_exDelegate respondsToSelector:@selector(rightItem)]) {
        [_exDelegate rightItem];
    }
}

- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title {
    if (_backButton) {
        [_backButton setHidden:!bShow];
    }
    
    if (self.navigationItem) {
        [self.navigationItem setTitle:title];
    }
    
    if (_rightButton) {
        [_rightButton setHidden:YES];
    }
}

- (void)setShowRightLeft:(BOOL)bLeftShow title:(NSString *)title right:(NSString *)rightTitle {
    if (_backButton) {
        [_backButton setHidden:!bLeftShow];
        
        if (bLeftShow) {
            [_backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        }
    }
    
    if (self.navigationItem) {
        [self.navigationItem setTitle:title];
    }
    
    if (_rightButton && title && ![@"" isEqualToString:rightTitle]) {
        [_rightButton setTitle:rightTitle forState:UIControlStateNormal];
        [_rightButton setHidden:NO];
    }
}



@end
