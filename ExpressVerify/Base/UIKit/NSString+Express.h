//
//  NSString+Express.h
//  Express
//
//  Created by Apple on 19/03/2018.
//  Copyright © 2018 HangZhouBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Express)

- (NSString *)base64EncodedString;
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;
- (NSString*) sha256;
- (NSData *) sha256Data;
@end
