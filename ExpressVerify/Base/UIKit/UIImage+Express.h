//
//  UIImage+Express.h
//  Express
//
//  Created by Apple on 09/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Express)

+ (UIImage*) createImageWithColor: (UIColor*) color;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

@end
