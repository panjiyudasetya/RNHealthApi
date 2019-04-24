//
//  RNExHealth.h
//  HealthApiPlayground
//
//  Created by Panji Y. Wiwaha on 22/04/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppleHealthKit.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>

@interface RNExHealth : NSObject<RCTBridgeModule>
@property (strong, nonatomic) AppleHealthKit* healthKit;
@end
