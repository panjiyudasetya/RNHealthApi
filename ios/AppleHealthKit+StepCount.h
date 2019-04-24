//
//  AppleHealthKit+StepCount.h
//  RNHealthApi
//
//  Created by Panji Y. Wiwaha on 23/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import <Foundation/Foundation.h>

@interface AppleHealthKit (StepCount)
- (void)getSumStepCount:(NSDate*)startDate
                endDate:(NSDate*)endDate
             completion:(void (^)(double value, NSError* _Nullable error))completion;
@end
