//
//  ExpressViewModel.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/9.
//

#import <Foundation/Foundation.h>

@class ExpressViewModel;

typedef void (^BitSuccessBlock) (ExpressViewModel *returnValue);
typedef void (^BitErrorCodeBlock) (NSString *errorCode);
typedef void (^BitFailureBlock)(ExpressViewModel *errorCode);

@interface ExpressViewModel : NSObject

@property (nonatomic, copy)   NSString *message;
@property (nonatomic, copy)   NSString *resource;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, weak)   NSArray *errors;

@property (nonatomic, copy) BitSuccessBlock bitSuccessBlock;
@property (nonatomic, copy) BitErrorCodeBlock bitErrorCodeBlock;
@property (nonatomic, copy) BitFailureBlock bitFailureBlock;

- (NSString *)formatUrl:(NSString *)funcName;

+ (NSString *)getBaseUri;

@end
