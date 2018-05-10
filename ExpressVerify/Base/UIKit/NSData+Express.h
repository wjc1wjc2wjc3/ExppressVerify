//
//  NSData+Express.h
//  Express
//
//  Created by Apple on 19/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Express)

- (nullable NSString *)base64EncodedString;
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;
- (nullable NSString *)hexString;
@end
