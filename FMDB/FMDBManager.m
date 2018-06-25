//
//  FMDBManager.m
//  HZBitApp
//
//  Created by Apple on 9/5/17.
//  Copyright © 2017 HZBit. All rights reserved.
//

#import "FMDBManager.h"

NSString *const kFMDBDataBaseFileName = @"ExpressZone.sqlite";
NSString *const kFMDBTableName = @"User";             //表名称
NSString *const kFMDBID = @"id";
NSString *const kFMDBName = @"name";                  //用户名
NSString *const kFMDBIdentity = @"identity";          //用户身份证
NSString *const kFMDBIssuance = @"issuance";          //签发时间
NSString *const kFMDBExpiration = @"expiration";      //有效期限
NSString *const kFMDBPhone = @"phone";                //电话号码
NSString *const kFMDBSid = @"sid";                    //用户sid

NSInteger maxDataBaseCount = 100;  //数据库存储的个人信息最大数据数

@interface FMDBManager ()

@property (nonatomic, strong) NSString * dbPath;
@property (nonatomic, strong) NSMutableDictionary *resultDict;

@end



@implementation FMDBManager

+ (FMDBManager*)sharedInstance {
    static FMDBManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString * doc = PATH_OF_DOCUMENT;
        NSString * path = [doc stringByAppendingPathComponent:kFMDBDataBaseFileName];
        _dbPath = path;
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
            // create it
            FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
            if ([db open]) {
                NSString * sql = [NSString stringWithFormat:@"create table if not exists '%@' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , '%@' text, '%@' text, '%@' text, '%@' text, '%@' text, '%@' text)", kFMDBTableName, kFMDBName, kFMDBIdentity, kFMDBIssuance, kFMDBExpiration, kFMDBPhone, kFMDBSid];
                BOOL res = [db executeUpdate:sql];
                if (!res) {
                    NSLog(@"error when creating db table");
                } else {
                    NSLog(@"succ to creating db table");
                }
                [db close];
            } else {
                NSLog(@"error when open db");
            }
        }
        else
        {
            [self deleteSuperfluous];
        }
        
        _resultDict = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return self;
}

- (void)deleteSuperfluous {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select COUNT(*) from %@;", kFMDBTableName];
        
        int count = [db intForQuery:sql];
        
        if (count > maxDataBaseCount) {
            
            NSString * sqlWhere = [NSString stringWithFormat:@"select * from %@", kFMDBTableName];
            FMResultSet *rs = [db executeQuery:sqlWhere];
            NSString *idx = nil;
            while ([rs next]) {
                idx = [rs stringForColumn:kFMDBID];
                break;
            }
            
            NSInteger startIdx = 0;
            if (idx != nil && [idx compare:@""] != NSOrderedSame) {
                startIdx = [idx integerValue];
            }
            
            
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ <= %ld;", kFMDBTableName, kFMDBID, startIdx + (count - maxDataBaseCount)];
            BOOL bDelete = [db executeUpdate:sql];
            if (bDelete) {
                //
            }
        }
    }
    [db close];
}

- (void)insertData:(NSString *)name identity:(NSString *)identity issuance:(NSString *)issuance expiration:(NSString *)expiration phone:(NSString *)phone sid:(NSString *)sid {
    if (name == nil || [name compare:@""] == NSOrderedSame) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        
        NSString * sql = [NSString stringWithFormat:@"insert into %@ (%@, %@, %@, %@, %@, %@) values(?, ?, ?, ?, ?, ?) ", kFMDBTableName, kFMDBName, kFMDBIdentity, kFMDBIssuance, kFMDBExpiration, kFMDBPhone, kFMDBSid];
        BOOL res = [db executeUpdate:sql, name, identity, issuance, expiration, phone, sid];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        
        [db close];
    }
}

- (void)update:(FMDatabase *)db phone:(NSString *)phone key:(NSString *)key value:(NSString *)value {
    if ([db columnExists:key inTableWithName:kFMDBTableName]) {
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName,key,kFMDBPhone];
        [db executeUpdate:update, phone, value];
    }else{
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add %@ text", kFMDBTableName, key];
        [db executeUpdate:sql];
        
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName, key, kFMDBPhone];
        [db executeUpdate:update, phone, value];
    }
}

- (void)updateWithIdentity:(FMDatabase *)db identity:(NSString *)identityNo key:(NSString *)key value:(NSString *)value {
    if ([db columnExists:key inTableWithName:kFMDBTableName]) {
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName,key,kFMDBIdentity];
        [db executeUpdate:update, value, identityNo];
    }else{
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add %@ text", kFMDBTableName, key];
        [db executeUpdate:sql];
        
        NSString *update = [NSString stringWithFormat:@"update %@ set %@=? where %@ = ?",kFMDBTableName, key, kFMDBIdentity];
        [db executeUpdate:update, identityNo, value];
    }
}

- (void)update:(NSString *)phone key:(NSString *)key value:(NSString *)value  {
    if (!phone || [phone compare:@""] == NSOrderedSame) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        [self update:phone key:key value:value];
        [db close];
    }
}

- (void)updateWithIdentity:(NSString *)identity key:(NSString *)key value:(NSString *)value  {
    if (!identity || [identity compare:@""] == NSOrderedSame) {
        return;
    }
    
    FMDatabase * db = [FMDatabase databaseWithPath:_dbPath];
    if ([db open]) {
        [self updateWithIdentity:db identity:identity key:key value:value];
        [db close];
    }
}

- (NSMutableDictionary *)queryData:(NSString *)phoneNumber {
    NSMutableDictionary *dict = [_resultDict objectForKey:phoneNumber];
    if (dict && dict.count > 0) {
        return dict;
    }
    
    NSMutableDictionary *result = [self queryData:kFMDBPhone value:phoneNumber];
    [_resultDict setValue:result forKey:phoneNumber];
    return result;
}

- (NSMutableDictionary *)queryData:(NSString *)key value:(NSString *)value {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    NSMutableDictionary  *resultDict = [NSMutableDictionary dictionaryWithCapacity:7];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"select * from %@", kFMDBTableName];
        sql = [sql stringByAppendingFormat:@" where %@=%@", key, value];
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            int userId = [rs intForColumn:kFMDBID];
            NSString * name = [rs stringForColumn:kFMDBName];
            NSString *identity = [rs stringForColumn:kFMDBIdentity];
            NSString *issuance = [rs stringForColumn:kFMDBIssuance];
            NSString *expiration = [rs stringForColumn:kFMDBExpiration];
            NSString *phone = [rs stringForColumn:kFMDBPhone];
            NSString *sid = [rs stringForColumn:kFMDBSid];
            
            if (userId) {
                [resultDict setObject:[NSString stringWithFormat:@"%d", userId] forKey:kFMDBID];
            }
            
            if (name) {
                [resultDict setObject:name forKey:kFMDBName];
            }
            
            if (identity) {
                [resultDict setObject:identity forKey:kFMDBIdentity];
            }
            
            if (issuance) {
                [resultDict setObject:issuance forKey:kFMDBIssuance];
            }
            
            if (expiration) {
                [resultDict setObject:expiration forKey:kFMDBExpiration];
            }
            
            if (phone) {
                [resultDict setObject:phone forKey:kFMDBPhone];
            }
            
            if (sid) {
                [resultDict setObject:sid forKey:kFMDBSid];
            }
            
//            DBEntity *entity = [[DBEntity alloc] initDictionary:resultDict];
            
        }
        [db close];
    }
    
    return resultDict;
}


- (void)deleteWidthAccount:(NSString *)account {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@ where %@ = %@",kFMDBTableName, kFMDBPhone, account];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
}

- (void)clearAll {
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:@"delete from %@",kFMDBTableName];
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to delete db data");
        } else {
            NSLog(@"succ to deleta db data");
        }
        [db close];
    }
}

- (void)dealloc {
    [_resultDict removeAllObjects];
    _resultDict = nil;
}

@end
