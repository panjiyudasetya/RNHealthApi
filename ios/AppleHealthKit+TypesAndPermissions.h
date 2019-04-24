//
//  AppleHealthKit+TypesAndPermission.h
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKStatisticsQuery.h>
#import <HealthKit/HKUnit.h>

@interface AppleHealthKit (TypesAndPermissions)
@property (strong, nonatomic, readonly) NSDictionary<NSString*, HKQuantityType*> *quantityTypes;
@property (strong, nonatomic, readonly) NSDictionary<NSString*, HKUnit*> *quantityUnits;

- (NSSet *) getReadPermissions:(NSArray<NSString *> * _Nonnull)dataTypes;

@end
