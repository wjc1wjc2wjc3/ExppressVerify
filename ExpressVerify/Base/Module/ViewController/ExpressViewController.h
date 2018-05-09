//
//  ExpressViewController.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import <UIKit/UIKit.h>
#import "ExpressNaviViewController.h"

@protocol ExpressViewControllerDelegate <NSObject>

@optional
- (void)pushViewController:(UIViewController *)viewController;
- (void)popBackMain;
@end

@interface ExpressViewController : UIViewController

@property (nonatomic, strong, readonly) ExpressViewModel *viewModel;
@property (nonatomic, weak) id<ExpressViewControllerDelegate> delegate;

- (instancetype)initWithViewModel:(ExpressViewModel *)viewModel;
- (void)showIndicator:(BOOL)bHiddenOther;
- (void)hiddenIndicator:(BOOL)bHiddenOther;

- (void)hideNaviBar;
- (void)showNaviBar:(NSString *)title;
- (void)showNaviBar:(BOOL)bShowBack title:(NSString *)title;
- (void)showRightLeftNaviBar:(BOOL)bShowBack title:(NSString *)title right:(NSString *)rightTitle;
- (void)setNavibarBlock:(naviBackBlock)block;
- (void)setNavibarRightBlock:(naviRightBlock)block;
- (void)setExtraCellLineHidden: (UITableView *)tableView;

- (void)pushViewController:(UIViewController *)viewController;
- (void)popBackMain;

- (void)setSubViewsOffset:(BOOL)decrease;
- (void)setSubViewOffset:(UIView *)offsetView decreaseHeight:(BOOL)decrease;

//解决UITableView顶部的空白区域问题
- (void)adjustTopWhiteZone:(UITableView *)tableView;

@end
