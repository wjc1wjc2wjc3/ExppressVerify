//
//  FindExpressViewModel.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import "FindExpressViewModel.h"

@implementation FindExpressViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    FindExpressViewModel *viewModel = [FindExpressViewModel mj_objectWithKeyValues:dictionary];
    return viewModel;
}

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param token:(NSString *)tokens {
    
    NSString *numbers = param[@"numbers"];
    NSString *suffix = [NSString stringWithFormat:@"%@/%@",FindExpress,numbers];
    
    return [APIManager SafePOSTWithJson:tokens url:[self formatUrl:suffix] parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        FindExpressViewModel *viewModel = [[FindExpressViewModel alloc] initWithDictionary:responseObject];
        if (viewModel.message) {
            [MBManager showBriefAlert:viewModel.message];
        }
        if (viewModel && viewModel.status == 0) {
            if (self.bitSuccessBlock) {
                self.bitSuccessBlock(viewModel);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

@end
