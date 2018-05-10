//
//  FindExpressData.h
//  ExpressVerify
//
//  Created by Apple on 2018/5/10.
//

#import <Foundation/Foundation.h>

@interface FindExpressData : NSObject

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *divisionCode;
@property (nonatomic, copy) NSString *divisionName;
@property (nonatomic, copy) NSString *policeStationCode;
@property (nonatomic, copy) NSString *policeStationName;
@property (nonatomic, copy) NSString *expressNumber;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *receiverCity;
@property (nonatomic, copy) NSString *receiverMobilephone;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *createDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
