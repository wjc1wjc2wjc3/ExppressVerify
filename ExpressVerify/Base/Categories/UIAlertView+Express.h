//
//  UIAlertView+Express.h
//  Express
//
//  Created by Apple on 14/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Express)
// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showWithBlock:(void(^)(NSInteger buttonIndex)) block;
@end
