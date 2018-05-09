//
//  FindExpressViewModel.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressViewModel.h"

@interface FindExpressViewModel : ExpressViewModel

@property (nonatomic, strong) NSDictionary *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param token:(NSString *)tokens;

@end
