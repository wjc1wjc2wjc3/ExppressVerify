//
//  ExpressViewModel.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressViewModel.h"

static NSString *baseUri = @"";

@implementation ExpressViewModel

- (NSString *)formatUrl:(NSString *)funcName {
    NSString *baseUriPrex = URI_EXPRESS_SERVER;
    if (self.bCity) {
        baseUriPrex = URI_EXPRESS_SERVER_CITY;
    }
    else
    {
        baseUriPrex = URI_EXPRESS_SERVER;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUriPrex, funcName];
    if ([@"" isEqualToString:baseUri]) {
        baseUri = [NSString stringWithFormat:@"%@", baseUriPrex];
    }
    return url;
}

+ (NSString *)getBaseUri {
    return baseUri;
}

@end
