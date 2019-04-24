//
//  AppleHealthKit.h
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HKHealthStore.h>

@interface AppleHealthKit : NSObject
@property (strong, nonatomic) HKHealthStore* healthStore;

- (void)hasPermissionsFor:(NSArray<NSString *> * _Nonnull)dataTypes completion:(void (^)(BOOL success, NSError * _Nullable error))completion;
- (void)askPermissionFor:(NSArray<NSString *> * _Nonnull)dataTypes completion:(void (^)(BOOL success, NSError * _Nullable error))completion;
- (void)disconnect: (void (^)(BOOL success, NSError * _Nullable error))completion;

@end
