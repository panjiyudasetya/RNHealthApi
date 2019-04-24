//
//  AppleHealthKit+Queries.h
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 23/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import <Foundation/Foundation.h>
#import <HealthKit/HKStatisticsQuery.h>
#import <HealthKit/HKUnit.h>

@interface AppleHealthKit (Queries)
- (void)fetchSumOfSamplesForType:(HKQuantityType *)quantityType
                       predicate:(NSPredicate*)predicate
                            unit:(HKUnit *)unit
                      completion:(void (^)(double, NSError *))completionHandler;
@end
