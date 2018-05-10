//
//  FindExpressViewModel.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "ExpressViewModel.h"
#import "FindExpressData.h"

@interface FindExpressViewModel : ExpressViewModel

@property (nonatomic, strong) FindExpressData *findExpressData;
@property (nonatomic, weak) NSDictionary *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param;

@end
