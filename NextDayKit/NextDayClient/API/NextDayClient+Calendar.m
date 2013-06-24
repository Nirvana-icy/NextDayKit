//
//  NextDayClient+Calendar.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-16.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient+Calendar.h"
#import "NextDayClientRequest.h"
#import "NSDate+nLibrary.h"
#import "NextDayClientConfig.h"

@implementation NextDayClient (Calendar)

- (void)getCalDataFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"cal.get",
                           @"from": fromDate.yyyyMMddString,
                           @"to": toDate.yyyyMMddString
                           };
  
  // Structure request
  NextDayClientRequest *request = [[NextDayClientRequest alloc] initAsAction];
  request.data[@"params"] = params;
  
  // Send request
  [self send:request completion:^(NSDictionary *responseDict, NSError *error) {
    if (error != nil) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    NSString *status = responseDict[@"status"];
    if ([status isEqualToString:@"FAIL"]) {
      // Handle error
      NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                           code:400
                                       userInfo:[NSDictionary dictionaryWithObject:responseDict[@"error"] forKey:NSLocalizedDescriptionKey]];
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
    } else if ([status isEqualToString:@"OK"]) {
      // Parse responseString and callback
      NSDictionary *result = responseDict[@"result"];
      if (completionHandler != nil)
        completionHandler(YES, result, error);
    }
  }];
}

- (void)getCalDataFromDates:(NSArray *)dateArray completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSMutableArray *array = [[NSMutableArray alloc] init];
  for (NSDate *date in dateArray)
    [array addObject:date.yyyyMMddString];
  NSDictionary *params = @{
                           @"action": @"cal.getByDates",
                           @"dates": array
                           };
  
  // Structure request
  NextDayClientRequest *request = [[NextDayClientRequest alloc] initAsAction];
  request.data[@"params"] = params;
  
  // Send request
  [self send:request completion:^(NSDictionary *responseDict, NSError *error) {
    if (error != nil) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    NSString *status = responseDict[@"status"];
    if ([status isEqualToString:@"FAIL"]) {
      // Handle error
      NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                           code:400
                                       userInfo:[NSDictionary dictionaryWithObject:responseDict[@"error"] forKey:NSLocalizedDescriptionKey]];
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
    } else if ([status isEqualToString:@"OK"]) {
      // Parse responseString and callback
      NSDictionary *result = responseDict[@"result"];
      if (completionHandler != nil)
        completionHandler(YES, result, error);
    }
  }];
}

- (void)getCalDataKeysAfterTS:(NSTimeInterval)ts completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"cal.getChangeLog",
                           @"ts": [NSString stringWithFormat:@"%.0f", ts]
                           };
  
  // Structure request
  NextDayClientRequest *request = [[NextDayClientRequest alloc] initAsAction];
  request.data[@"params"] = params;
  
  // Send request
  [self send:request completion:^(NSDictionary *responseDict, NSError *error) {
    if (error != nil) {
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
      return;
    }
    
    NSString *status = responseDict[@"status"];
    if ([status isEqualToString:@"FAIL"]) {
      // Handle error
      NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                           code:400
                                       userInfo:[NSDictionary dictionaryWithObject:responseDict[@"error"] forKey:NSLocalizedDescriptionKey]];
      if (completionHandler != nil)
        completionHandler(NO, nil, error);
    } else if ([status isEqualToString:@"OK"]) {
      // Parse responseString and callback
      NSArray *result = responseDict[@"result"];
      if (completionHandler != nil)
        completionHandler(YES, result, error);
    }
  }];
}


@end
