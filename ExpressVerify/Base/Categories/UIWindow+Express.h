//
//  UIWindow+Express.h
//  Express
//
//  Created by Apple on 14/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Express)

/**
 Returns the current Top Most ViewController in hierarchy.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

/**
 Returns the topViewController in stack of topMostController.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
