//
//  YTDMacros.h
//  msLBS
//
//  Created by venusfeng on 14/12/19.
//  Copyright (c) 2014年 ytdinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

///Size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define STATUBAR_HEIGHT 20.f
#define NAVIGATIONBAR_HEIGHT 64.f
#define NAVIGATIONBAR_ORIGIN_OFFSET ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? 0 : 20.f)

///Fonts
#define kFontOfSize(fontSize) [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]
#define kFontOfSizeBold(fontSize) [UIFont fontWithName:@"STHeitiSC-Medium" size:fontSize]

///---------------------------
/// @name IsIOS7
///---------------------------
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define CurrentVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 * get systemVersion for currentDevice
 */
#define IS_iOS9 [[UIDevice currentDevice].systemVersion floatValue] >= 9.0f
#define IS_iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f && [[UIDevice currentDevice].systemVersion floatValue] < 9.0f)
#define IS_iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f && [[UIDevice currentDevice].systemVersion floatValue] < 8.0f)


#define DEVICE_BIGGER_THAN_IPHONE4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) > DBL_EPSILON )

/**
 Simple Shortcut for your NSLocalizedString(@"..", @"..")
 */
#define _(_key) NSLocalizedString( _key , nil)

///---------------------------
/// @name NSNotificationCenter
///---------------------------

/**
 Shortcut for [[NSNotificationCenter ...] postNotificationName: ...]
 @param notificationName - The notification name you want to post
 @param obj - The object for the notification
 @param userInfoDictionary - The NSDictionary for the userInfo
 */
#define notify(_notificationName, _obj, _userInfoDictionary) [[NSNotificationCenter defaultCenter] postNotificationName: _notificationName object: _obj userInfo: _userInfoDictionary]

/**
 Shortcut for [[NSNotificationCenter ...] addObserver: ...]
 @param notificationName - The notification name you want to post
 @param observer - The observer object
 @param observerSelector - The current selector for the notificaton
 */
#define addObserver(_notificationName, _observer, _observerSelector, _obj) [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(_observerSelector) name:_notificationName object: _obj]

/**
 Shortcut for [[NSNotificationCenter ...] removeObserver: ...]
 @param observer - The observer object that should be remove from the NSNotificationCenter
 */
#define removeObserver(_observer) [[NSNotificationCenter defaultCenter] removeObserver: _observer]

/**
 Runtime check for the current version Nummer.
 checks CURRENT_VERSION_NUMBER < GIVEN_VERSION_NUMBER
 @_gVersion - the given Version Number. aka (_iOS_7_0 or NSFoundationVersionNumber_iOS_7_0 and so on)
 */
#define SYSTEM_VERSION_LESS_THAN(_gVersion)                 ( floor(NSFoundationVersionNumber) <  _gVersion )


#define IFNULL(a, b) (a == [NSNull null] || a == nil ? b : a)

#define NOTNULL(a,b) (a != nil && ![a isKindOfClass:[NSNull class]] ? a:b)

///------------------------
///	路径
///------------------------
//我的应用信息路径
#define MyAppDatabasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)) lastObject]stringByAppendingPathComponent:@"myApplications.sqlite"]

///------------------------
///	常亮
///------------------------
/** 占位*/
//占位图片
#define PLACEHLODER_IMAGE [UIImage imageNamed:@"icon-image-placeholder"]
#define WORKCIRCEL_DEFAULT_IMAGE [UIImage imageNamed:@"pbg.jpg"]
