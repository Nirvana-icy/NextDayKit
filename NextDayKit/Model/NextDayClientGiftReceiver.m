//
//  NextDayClientGiftReceiver.m
//  NextDayKit
//
//  Created by nickcheng on 13-7-3.
//  Copyright (c) 2013年 nx. All rights reserved.
//

#import "NextDayClientGiftReceiver.h"

@implementation NextDayClientGiftReceiver {
  NSString *_weiboID;
  NSString *_weiboName;
  NSString *_weiboRemark;
  NSString *_weiboAvatar;
  NSString *_timezoneID;
  NSString *_scheduledDate;
  NSInteger _weiboGender;
}

@synthesize weiboID = _weiboID;
@synthesize weiboName = _weiboName;
@synthesize weiboRemark = _weiboRemark;
@synthesize weiboAvatar = _weiboAvatar;
@synthesize timezoneID = _timezoneID;
@synthesize scheduledDate = _scheduledDate;
@synthesize weiboGender = _weiboGender;

#pragma mark -
#pragma mark Init

- (id)init {
  //
	if((self = [super init]) == nil) return nil;
  
  // Custom initialization
  _weiboID = nil;
  _weiboName = nil;
  _weiboRemark = nil;
  _weiboAvatar = nil;
  _timezoneID = nil;
  _scheduledDate = nil;
  _weiboGender = 0;
  
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSDictionary *)dict {
  NSDictionary *result = @{
                           @"weiboId": self.weiboID,
                           @"weiboName": self.weiboName,
                           @"weiboRemark": self.weiboRemark,
                           @"weiboAvatar": self.weiboAvatar,
                           @"timezoneId": self.timezoneID,
                           @"scheduledDate": self.scheduledDate,
                           @"weiboGender": [NSNumber numberWithInteger:self.weiboGender]
                           };
  
  return result;
}

@end
