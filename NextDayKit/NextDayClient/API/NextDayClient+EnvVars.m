//
//  NextDayClient+EnvVars.m
//  NextDayKit
//
//  Created by nickcheng on 13-6-23.
//  Copyright (c) 2013年 Next Experience Interactive. All rights reserved.
//

#import "NextDayClient+EnvVars.h"
#import "NextDayClientRequest.h"
#import "NextDayClientConfig.h"
#import "NextDayClientEnvVars.h"

@implementation NextDayClient (EnvVars)

- (void)setVars:(NextDayClientEnvVars *)envVars completion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSMutableDictionary *pr = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"envVars.set", @"action", nil];
  // Check required params
  if (envVars.weiboID == nil
      || envVars.weiboToken == nil
      || envVars.weiboTokenExpiresAt == nil
      || envVars.deviceId == nil) {
    NDLE(@"Required params not found!");
    NSError *error = [NSError errorWithDomain:NEXTDAYCLIENT_ERRORDOMAIN
                                         code:404
                                     userInfo:[NSDictionary dictionaryWithObject:@"Required params not found!" forKey:NSLocalizedDescriptionKey]];
    if (completionHandler != nil)
      completionHandler(NO, nil, error);
    return;
  }
  [pr setObject:envVars.weiboID forKey:@"weiboId"];
  [pr setObject:envVars.weiboToken forKey:@"weiboToken"];
  [pr setObject:envVars.weiboTokenExpiresAt forKey:@"weiboTokenExpiresAt"];
  [pr setObject:envVars.deviceId forKey:@"deviceId"];
  // Check other params
  if (envVars.weiboName != nil) [pr setObject:envVars.weiboName forKey:@"weiboName"];
  if (envVars.weiboAvatar != nil) [pr setObject:envVars.weiboAvatar forKey:@"weiboAvatar"];
  if (envVars.apnToken != nil) [pr setObject:envVars.apnToken forKey:@"apnToken"];
  NSDictionary *params = pr;
  
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
      if (completionHandler != nil)
        completionHandler(YES, nil, error);
    }
  }];
}

- (void)getVarsWithCompletion:(NextDayClientCompletionBlock)completionHandler {
  // Structure params
  NSDictionary *params = @{
                           @"action": @"envVars.get",
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

@end