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
    viewModel.findExpressData = [[FindExpressData alloc] initWithDictionary:viewModel.data];
    return viewModel;
}

- (NSURLSessionDataTask *)startRequest:(NSDictionary *)param {
    
    NSString *numbers = param[@"numbers"];
    NSString *suffix = [NSString stringWithFormat:@"%@/%@",FindExpress,numbers];
    NSString *url = [self formatUrl:suffix];
    return [APIManager SafeGET:url parameters:param success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
            FindExpressViewModel *viewModel = [[FindExpressViewModel alloc] initWithDictionary:responseObject];

            if (viewModel && viewModel.status == 1) {
                if (viewModel.message) {
                    [MBManager showBriefAlert:viewModel.message];
                }
                if (self.bitSuccessBlock) {
                    self.bitSuccessBlock(viewModel);
                }
                
            }
            else if (viewModel.status == 0)
            {
//                [MBManager showBriefAlert:@"没有此快递单号的信息"];
                if (self.bitFailureBlock) {
                    self.bitFailureBlock(viewModel);
                }
            }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
            [MBManager showBriefAlert:error.localizedDescription];
    }];
    
}

@end
