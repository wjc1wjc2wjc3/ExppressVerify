//
//  FindExpressData.m
//  ExpressVerify
//
//  Created by Apple on 2018/5/10.
//

#import "FindExpressData.h"

@implementation FindExpressData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    FindExpressData *data = [FindExpressData mj_objectWithKeyValues:dictionary];
    return data;
}

@end
