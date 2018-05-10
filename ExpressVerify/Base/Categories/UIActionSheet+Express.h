//
//  UIActionSheet+Express.h
//  Express
//
//  Created by Apple on 14/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Express)

- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx,NSString* buttonTitle))block;

@end
