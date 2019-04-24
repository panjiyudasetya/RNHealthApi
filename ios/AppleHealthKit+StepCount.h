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
- (void)getStepCountToday: (void (^)(double value, NSError* _Nullable error))completion;
@end
