//
//  ExpressNavigationBar.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import <UIKit/UIKit.h>

@protocol ExpressNavigationBarDelegate <NSObject>

@optional
- (void)backItem;
- (void)rightItem;
@end

@interface ExpressNavigationBar : UINavigationBar

@property (nonatomic, strong) UINavigationItem *navigationItem;
@property (nonatomic, weak) id<ExpressNavigationBarDelegate> exDelegate;

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)leftImageName;

- (void)setShowBackItem:(BOOL)bShow title:(NSString *)title;

- (void)setShowRightLeft:(BOOL)bLeftShow title:(NSString *)title right:(NSString *)rightTitle;

- (void)setNaviBackgroundColor:(UIColor *)color;

- (void)addRightItemButton:(UIButton *)button;

@end
