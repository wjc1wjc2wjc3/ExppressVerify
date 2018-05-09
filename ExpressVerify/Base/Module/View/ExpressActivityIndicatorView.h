//
//  ExpressActivityIndicatorView.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import <UIKit/UIKit.h>

@interface ExpressActivityIndicatorView : UIView

+(_Nonnull instancetype)defaultIndicator;

@property(nonatomic) BOOL hidesWhenStopped;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
