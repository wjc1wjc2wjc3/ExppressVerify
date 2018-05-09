//
//  ExpressNaviViewController.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import <UIKit/UIKit.h>
#import "ExpressNavigationBar.h"

typedef void(^naviBackBlock)(void);
typedef void(^naviRightBlock)(void);

@interface ExpressNaviViewController : UINavigationController

@property (nonatomic, strong)ExpressNavigationBar *expressNavigationBar;

@property (nonatomic, copy)naviBackBlock backBlock;
@property (nonatomic, copy)naviRightBlock rightBlock;

- (void)remnoveNavigationBar;
- (void)hideNavigationBar;
- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title;
- (void)showNavigationBar:(BOOL)bShowBack title:(NSString *)title right:(NSString *)rightTitle;
- (void)setNaviBackgroundColor:(UIColor *)color;
- (void)addMenuBar;
- (void)addBackBar;

@end
