//
//  Utilities.h
//  eOrder
//
//  Created by venusfeng on 14/7/14.
//  Copyright (c) 2014年 ytd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Utilities : NSObject

+(NSDate *) convertToNSDate:(NSString *) dateInStringFormat;

+(NSDate *) convertToNSDate:(NSString *) dateInStringFormat patterm:(NSString*) patterm;

+(NSString *) formatIntDateToString:(NSString *) dateInIntFormat;

+(NSString *) convertToNSString:(NSDate *) date;

+(NSString *) formatDateTime:(NSDate *)date;

+(NSString *) formatToShortDateString:(NSDate *)date;

+(NSString*) formatDateTimeYear_Month:(NSDate *)date;

+(NSString *) formatToMonthDateString:(NSDate *)date;

+(NSString *) formatDateTime:(NSDate *)date withPatterm:(NSString *)patterm;

+(NSString*)formatDateToStrDetailWithTimeStr:(NSString*)time;

+(NSString*)formatDateToStrDetailWithDate:(NSDate*)date;

+(NSString *) getNowTimeInterval;

+(void) clearSubViews:(UIView *)parentView;

+(void) showInfoView:(NSString *)message;

+(void) showErrorView:(NSString *)message;

/** 没有网络连接*/
+(void) showNotReachableView:(CXAlertButtonHandler) handler;

+(UIImage *)cutFromImage:(UIImage *)image inRect:(CGRect)rect;

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+(NSString*) jsonStringFromData:(id) data;

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

+ (UIImage*)imageFromView:(UIView*)view;

+ (UIImage *)imageWithScreenContents;

+ (NSString *)formatDistance:(double)distance;

+ (double)getDistance:(CLLocation *)fromLocation to:(CLLocation *)toLocation;

+ (int)minutesBetween:(NSString *)fromTime toToTime:(NSString *)toTime;

+ (NSDate *)dateAfterMinutes:(int)minute sinceDate:(NSString *)date withPatterm:(NSString *)patterm;

+ (NSDate *)localDate;

+ (NSDate *)toLocalDate:(NSDate *)gtmDate;
/*
 从颜色字符串中取颜色值，一般是以#开头的字符串，例如:#000000、#FFFFFF
 */
+(UIColor *)colorStringToColor:(NSString *)colorString;

//number to 10:22
+(NSString *)formatTimeByNumber:(float)time;

//number transfer  B to (KB or GB)
+(NSString *)transferNumberToString:(double)number;

//file operator
+(NSString *) md5HexDigest :(NSString *)originString;
+(NSString *)applicationDocumentPath;//得到Document文件夹
+(BOOL)isExistFileAtPath:(NSString *)path;//是否存在指定文件
+(BOOL)removeFileAtPath:(NSString *)path;//删除path文件
+(double)getFileSizeAtPath:(NSString *)path;

+(BOOL)isValidateEmail:(NSString *)email;

+(NSString *) GetIOSUUID;

+(AFHTTPRequestOperationManager *)defaultHttpRequestManager;
+(AFHTTPRequestOperationManager *)defaultGetHttpRequestManager;

+(NSMutableDictionary *)getAllDaysOfYear:(NSInteger)year ofMonth:(NSInteger)month;

/**更新新版本*/
+(void)updateApp;
+(void)autoUpdateApp;

@end
