//
//  YTDMacros.h
//  msLBS
//
//  Created by venusfeng on 14/12/19.
//  Copyright (c) 2014年 ytdinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

/** app key*/
//oneapm 性能监控
#define appkey_oneapm @"ADACCA9E4AA5AFE7D7C5594BFB6E039076"

//百度地图key
#define BMKKEY @"QlieoECYSow6LYphIAVVt25DDw71pGz1"
//每米多少维度
#define LatitudeDeltaPerMeter 9.009009e-6
//每米多少经度
#define LongitudeDeltaPerMeter 1.171097e-5

/** 路径*/
//我的应用信息路径
#define MyAppDatabasePath [[(NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)) lastObject]stringByAppendingPathComponent:@"myApplications.sqlite"]

/** 占位*/
//占位图片
#define PLACEHLODER_IMAGE [UIImage imageNamed:@"icon-image-placeholder"]
#define WORKCIRCEL_DEFAULT_IMAGE [UIImage imageNamed:@"pbg.jpg"]

/** 通用*/
//图片压缩比例
#define Image_compression 0.3f
//长文本长度限制
#define TEXT_LENGTH 125

#define PI 3.1416
#define PAGE_SIEZ 10

///Size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define STATUBAR_HEIGHT 20.f
#define NAVIGATIONBAR_HEIGHT 64.f
#define NAVIGATIONBAR_ORIGIN_OFFSET ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? 0 : 20.f)

//导航条默认颜色
#define NAVIGATIONBAR_BACKGROUNDCOLOR [UIColor colorWithRed:130/255.0 green:197/255.0 blue:66/255.0 alpha:1.0]
//TabBar高度
#define TABBARHEIGHT 48

//Tab默认颜色
#define TAB_ITEMSELECTEDCOLOR [UIColor colorWithRed:113/255.0 green:192/255.0 blue:188/255.0 alpha:1.0]
//分割线颜色
#define kColorSeparator [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]
//正常文字颜色
#define kColorTextDetail [UIColor colorWithRed:112/255.0 green:112/255.0 blue:112/255.0 alpha:1.0]

//默认灰色
#define kColorGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]
///按钮颜色
///正常按钮颜色
#define kColorBtnNormal [UIColor colorWithRed:249/255.0 green:52/255.0 blue:64/255.0 alpha:1.0]
#define kColorBtnWhite [UIColor whiteColor]
///按钮容器颜色
#define kColorBtnContent [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:0.9]
//只读按钮颜色
#define kColorReadonly [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0]

//遮罩层
#define kColorMaskBlack [UIColor colorWithRed:0.f/255.0 green:0.f/255.0 blue:0.f/255.0 alpha:0.7]
#define kColorMaskGray [UIColor colorWithRed:0.f/255.0 green:0.f/255.0 blue:0.f/255.0 alpha:0.5]
#define kColorMaskGreen [UIColor colorWithRed:130.f/255.0 green:197.f/255.0 blue:66.f/255.0 alpha:0.7]

//高亮
#define kColorHeightLigth [UIColor colorWithRed:180.0/255 green:180.0/255 blue:180.0/255 alpha:0.9]

//占位符颜色
#define kColorTextPlaceHolder [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1.0]
//静态label内容颜色
#define kColorTextStaticLabelDetail [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]

//分割线颜色
#define kColorSplitLine [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]
//进度条背景色
#define kColorProgressBG [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]

//分区标题背景颜色
#define kColorSection [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0]

//透明
#define kColorClear [UIColor clearColor]
///背景色
#define kColorBackGroud [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]

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

/** 通知name*/
// 网络状态改变
#define notify_name_networkstatuschange @"notify_name_networkstatuschange___"

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

