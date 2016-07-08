//
//  Utilities.m
//  eOrder
//
//  Created by venusfeng on 14/7/14.
//  Copyright (c) 2014年 ytd. All rights reserved.
//

#import "Utilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utilities

+(NSDate *) convertToNSDate:(NSString *) dateInStringFormat{
    if (!dateInStringFormat) {
        return [[NSDate alloc] init];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateInStringFormat];
    return date;
}

+(NSDate *) convertToNSDate:(NSString *) dateInStringFormat patterm:(NSString*) patterm{
    if (!dateInStringFormat) {
        return [[NSDate alloc] init];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:patterm];
    NSDate *date = [dateFormatter dateFromString:dateInStringFormat];
    return date;
}

+(NSString *) formatIntDateToString:(NSString *) dateInIntFormat{
    
    if (dateInIntFormat.length != 8) {
        return dateInIntFormat;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:dateInIntFormat];
    
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *) convertToNSString:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSString *stringValue = [dateFormatter stringFromDate:date];
    return stringValue;
}

+(NSString *) formatDateTime:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *stringValue = [dateFormatter stringFromDate:date];
    return stringValue;
}

+(NSString*) formatDateTimeYear_Month:(NSDate *)date{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM"];
  NSString *stringValue = [dateFormatter stringFromDate:date];
  return stringValue;
}

+(NSString *) formatToShortDateString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *stringValue = [dateFormatter stringFromDate:date];
    return stringValue;
}

+(NSString *) formatToMonthDateString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *stringValue = [dateFormatter stringFromDate:date];
    return stringValue;
}

+(NSString *) formatDateTime:(NSDate *)date withPatterm:(NSString *)patterm{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:patterm];
    NSString *stringValue = [dateFormatter stringFromDate:date];
    return stringValue;
}


+(NSString*)formatDateToStrDetailWithTimeStr:(NSString*)time{
  if (!time||time.length<19) {
    return nil;
  }
  NSDateFormatter *formater = [[NSDateFormatter alloc]init];
  formater.dateFormat =@"yyyy-MM-dd HH:mm:ss";
  //源时间
  NSDate *date = [formater dateFromString:time];
  //当前时间
  NSDate *currentDate = [NSDate date];
  
  NSCalendar *cal = [NSCalendar currentCalendar];
  NSDateComponents *cmp = [cal components:(NSYearCalendarUnit|NSDayCalendarUnit| NSHourCalendarUnit) fromDate:date];
  NSDateComponents *currentCmp = [cal components:(NSYearCalendarUnit|NSDayCalendarUnit) fromDate:currentDate];
  
  if (cmp.year!=currentCmp.year) {
    formater.dateFormat =@"yyyy-MM-dd HH:mm";
  }else{
    NSInteger dayOffset = currentCmp.day - cmp.day;
    switch (dayOffset) {
      case 0:
        if (cmp.hour<12) {
          formater.dateFormat =@"上午 HH:mm";
        }else{
          formater.dateFormat =@"下午 HH:mm";
        }
        break;
      case 1:
        formater.dateFormat =@"昨天 HH:mm";
        break;
      case 2:
        formater.dateFormat =@"前天 HH:mm";
        break;
      default:
        formater.dateFormat =@"MM-dd HH:mm";
        break;
    }
  }
  NSString *str = [formater stringFromDate:date];
  return str;
}

+(NSString*)formatDateToStrDetailWithDate:(NSDate*)date{
  NSString *time = nil;
  if (date) {
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) { // 今天
      formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
      formatter.dateFormat = @"MM-dd HH:mm";
    } else {
      formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    time = [formatter stringFromDate:date];
  }
  return time;
}

+(NSString *) getNowTimeInterval{
  return [NSString stringWithFormat:@"%.0f", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970]];
}

+(void) clearSubViews:(UIView *)parentView{
    for (UIView *subView in parentView.subviews) {
        [subView removeFromSuperview];
    }
}

//+(void) showErrorView:(NSString *)message{
//    CXAlertView *alert = [[CXAlertView alloc] initWithTitle:NSLocalizedString(@"错误", @"错误") message:message cancelButtonTitle:NSLocalizedString(@"确定", @"OK") ];
//    [alert show];
//}

//+(void) showNotReachableView:(CXAlertButtonHandler) handler{
//	CXAlertView *alert = [[CXAlertView alloc] initWithTitle:NSLocalizedString(@"错误", @"错误") message:@"请检查联网状态！" cancelButtonTitle:nil ];
//	[alert addButtonWithTitle:NSLocalizedString(@"确定", @"OK") type:CXAlertViewButtonTypeCancel handler:handler];
//	
//	[alert show];
//}

//+(void) showInfoView:(NSString *)message{
//    CXAlertView *alert = [[CXAlertView alloc] initWithTitle:NSLocalizedString(@"信息", @"信息") message:message cancelButtonTitle:NSLocalizedString(@"确定", @"OK") ];
//    [alert show];
//}

+(UIImage *)cutFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize, image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+(NSString*)jsonStringFromData:(id)data{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:NULL];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 3 * M_PI_2;
    CGRect rect = CGRectMake(0, 0, image.size.width,image.size.height);
    float translateX = -rect.size.height;
    float translateY = 0;
    float scaleX = rect.size.height/rect.size.width;
    float scaleY = rect.size.width/rect.size.height;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

+ (UIImage*)imageFromView:(UIView*)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithScreenContents
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+(UIColor *)colorStringToColor:(NSString *)colorString
{
  NSString *cString;
  if ([[colorString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"]) {
    cString = [NSString stringWithFormat:@"0x%@", [colorString substringFromIndex:1]];
  } else {
    cString = [NSString stringWithFormat:@"0x%@", colorString];
  }
  unsigned long color = strtoul([cString UTF8String],0,16);
  return [UIColor colorWithRed:((color>>16)&0xFF)/255.0 green:((color>>8)&0xFF)/255.0 blue:(color&0xFF)/255.0 alpha:1.0];
}

+ (NSString *)formatDistance:(double)distance{
    if (distance < 1000.0f) {
        return [NSString stringWithFormat:@"%.0fm", distance];
    } else {
        return [NSString stringWithFormat:@"%.2fkm", distance / 1000];
    }
}

+ (double)getDistance:(CLLocation *)fromLocation to:(CLLocation *)toLocation{
    CLLocationDistance meters = [fromLocation distanceFromLocation:toLocation];
    return meters;
}

+ (int)minutesBetween:(NSString *)fromTime toToTime:(NSString *)toTime{
    int minutes = 0;
    
    NSDate *fromDate = [Utilities convertToNSDate:fromTime patterm:@"HH:mm"];
    NSDate *toDate = [Utilities convertToNSDate:toTime patterm:@"HH:mm"];
    
    if ([toDate compare:fromDate] == NSOrderedAscending) {
        toDate = [NSDate dateWithTimeInterval:24*3600 sinceDate:toDate];
    }
    
    minutes = [toDate timeIntervalSinceDate:fromDate] / 60;
    return minutes;
}

+ (NSDate *)dateAfterMinutes:(int)minute sinceDate:(NSString *)date withPatterm:(NSString *)patterm{
    NSDate *fromDate = [Utilities convertToNSDate:date patterm:patterm];
    return [NSDate dateWithTimeInterval:20*60 sinceDate:fromDate];
}

+(NSDate *)localDate{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSDate *)toLocalDate:(NSDate *)gtmDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: gtmDate];
    NSDate *localeDate = [gtmDate dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString *)formatTimeByNumber:(float)time
{
    NSString *result=@"00:00";
    if(time>=3600)//hour
    {
        int hour= time/3600;
        int minute=(time-hour*3600)/60;
        int second=time-hour*3600-minute*60;
        
        NSString *hourString=[NSString stringWithFormat:@"%d",hour];
        if(hour<10)
        {
            hourString=[NSString stringWithFormat:@"0%d",hour];
        }
        
        NSString *minString=[NSString stringWithFormat:@"%d",minute];
        if(minute<10)
        {
            minString=[NSString stringWithFormat:@"0%d",minute];
        }
        
        NSString *secondString=[NSString stringWithFormat:@"%d",second];
        if(second<10)
        {
            secondString=[NSString stringWithFormat:@"0%d",second];
        }
        
        result=[NSString stringWithFormat:@"%@:%@:%@",hourString,minString,secondString];
    }
    else if(time<3600)
    {
        
        int minute=time/60;
        int second=time-minute*60;;
        NSString *minString=[NSString stringWithFormat:@"%d",minute];
        if(minute<10)
        {
            minString=[NSString stringWithFormat:@"0%d",minute];
        }
        
        NSString *secondString=[NSString stringWithFormat:@"%d",second];
        if(second<10)
        {
            secondString=[NSString stringWithFormat:@"0%d",second];
        }
        
        result=[NSString stringWithFormat:@"%@:%@",minString,secondString];
    }
    return result;
}

+(NSString *)transferNumberToString:(double)number
{
    NSString *result=@"";

    //byte
    if(number<1024)
    {
        result=[NSString stringWithFormat:@"%0.1fB",number];
    }
    //kB
    else if(number<1024*1024)
    {
        result=[NSString stringWithFormat:@"%0.1fK",number/1024.0];
    }
    //MB
    else if(number<1024*1024*1024)
    {
        result=[NSString stringWithFormat:@"%0.1fM",number/1024.0/1024.0];
    }
    //GB
    else
    {
        result=[NSString stringWithFormat:@"%0.1fG",number/1024.0/1024.0/1024.0];
    }
    return result;
}

+(NSString *)applicationDocumentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+(double)getFileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error=nil;
    NSDictionary *ret=[fileManager attributesOfItemAtPath:path error:&error];
    if(error)
    {
        NSLog(@"getFileSizeAtPath===============%@",error);
    }
    return [[ret objectForKey:NSFileSize] doubleValue];
}

+(BOOL)isExistFileAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

+(BOOL)removeFileAtPath:(NSString *)path
{
    NSError *error=nil;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path])
    {
        return NO;
    }
    BOOL result= [fileManager removeItemAtPath:path error:&error];
    if(error)
    {
        NSLog(@"移除文件失败：%@",error);
        result=NO;
    }
    return result;
}

+(NSString *) md5HexDigest :(NSString *)originString
{
    const char *str = [originString UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//+(NSString *) GetIOSUUID
//{
//    NSString *sRetUUID;
//    
//    NSString *retrieveuuid = [SSKeychain passwordForService:@"com.ytdinfo.hongtu" account:@"uuid"];
//    if ( retrieveuuid == nil || [retrieveuuid isEqualToString:@""])
//    {
//        CFUUIDRef uuid = CFUUIDCreate(NULL);
//        assert(uuid != NULL);
//        CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//        retrieveuuid = [NSString stringWithFormat:@"%@", uuidStr];
//        [SSKeychain setPassword: retrieveuuid
//                     forService:@"com.ytdinfo.hongtu" account:@"uuid"];
//    }
//    if (retrieveuuid != nil)
//    {
//        sRetUUID = [NSString stringWithUTF8String:[retrieveuuid UTF8String]];
//    }
//    
//    return sRetUUID;
//}

+(AFHTTPRequestOperationManager *)defaultHttpRequestManager{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	AFJSONRequestSerializer* jsonSerializer = [AFJSONRequestSerializer serializer];
	/** 重写url拼接过滤，去除使用delete方法parameter拼接到url的queryString*/
	jsonSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
  manager.requestSerializer = jsonSerializer;
//  [manager.requestSerializer setValue:ESB_APP_KEY forHTTPHeaderField:@"app_key"];
  [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"sign"];
  [manager.requestSerializer setValue:[Utilities getNowTimeInterval] forHTTPHeaderField:@"timestamp"];
	[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

  
  return manager;
}

+(AFHTTPRequestOperationManager *)defaultGetHttpRequestManager{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  AFJSONRequestSerializer* jsonSerializer = [AFJSONRequestSerializer serializer];
  /** 重写url拼接过滤，去除使用delete方法parameter拼接到url的queryString*/
  jsonSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
  manager.requestSerializer = jsonSerializer;
//  [manager.requestSerializer setValue:ESB_APP_KEY forHTTPHeaderField:@"app_key"];
  [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"sign"];
  [manager.requestSerializer setValue:[Utilities getNowTimeInterval] forHTTPHeaderField:@"timestamp"];
  
  
  return manager;
}

+(NSMutableDictionary *)getAllDaysOfYear:(NSInteger)year ofMonth:(NSInteger)month{
  NSString *dateString = [NSString stringWithFormat:@"%ld-%02ld-%@", (long)year, (long)month , @"01"];
  NSDate *date = [Utilities convertToNSDate:dateString patterm:@"yyyy-MM-dd"];
  
  NSMutableDictionary *dicDays = [NSMutableDictionary dictionary];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
  
  for (int i = 0; i<range.length; i++) {
    NSString *day = [NSString stringWithFormat:@"%ld-%02ld-%02d", (long)year, (long)month, i+1];
    
    [dicDays setValue:[NSMutableArray array] forKey:day];
  }
  return dicDays;
}


+(void)updateApp{
//  if ([CommonRegister shareRegister].currentNetworkStatus == AFNetworkReachabilityStatusNotReachable) {
//    [Utilities showErrorView:@"您的网络不可用，无法进行系统版本检测，请检查您的网络设置."];
//    return;
//  }
//  
//  [MBHttpProgressHUD processBeginInView:[UIApplication sharedApplication].keyWindow];
	
//  NSString *nowVersion = [CommonSettings currentVersion];
//  AFHTTPRequestOperationManager *manager = [Utilities defaultHttpRequestManager];
//  NSDictionary *parameters = @{@"devicetype":@"ios"};
//  [manager GET:FULL_WEB_URL(GETLASTESTVERSION) parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//    
//    [MBHttpProgressHUD processSuccessInViewWithOutHUD:[AppDelegate sharedDelegate].window complete:nil];
//    
//    NSString *version = [responseObject valueForKey:@"version"];
//    NSString *downloadUrl = [responseObject valueForKey:@"downloadurl"];
//    downloadUrl = [NSString stringWithFormat:APPUPDATEURL, downloadUrl];
//    if (![version isEqualToString:nowVersion]) {
//      
//      CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"系统更新" message:@"您的系统有新版本，确认要更新吗" cancelButtonTitle:@"取消"];
//      
//      [alertView addButtonWithTitle:@"确认" type:CXAlertViewButtonTypeCustom handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
//        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [alertView dismiss];
//        NSURL *url = [NSURL URLWithString:downloadUrl];
//        [[UIApplication sharedApplication] openURL:url];
//      }];
//      [alertView show];
//    }
//    else
//    {
//      [Utilities showInfoView:@"您的系统是最新版本"];
//    }
//  } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//    [MBHttpProgressHUD processErrorInView:[AppDelegate sharedDelegate].window complete:nil];
//    [Utilities showInfoView:@"获取系统版本失败"];
//  }];
}

+(void)autoUpdateApp{
//  NSString *nowVersion = [CommonSettings currentVersion];
//  AFHTTPRequestOperationManager *manager = [Utilities defaultHttpRequestManager];
//  NSDictionary *parameters = @{@"devicetype":@"ios"};
//  [manager GET:FULL_WEB_URL(GETLASTESTVERSION) parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//    
//    NSString *version = [responseObject valueForKey:@"version"];
//    NSString *downloadUrl = [responseObject valueForKey:@"downloadurl"];
//    downloadUrl = [NSString stringWithFormat:APPUPDATEURL, downloadUrl];
//    if (![version isEqualToString:nowVersion]) {
//      CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:@"系统更新" message:@"您的系统有新版本，确认要更新吗" cancelButtonTitle:@"取消"];
//      
//      [alertView addButtonWithTitle:@"确认" type:CXAlertViewButtonTypeCustom handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
//        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [alertView dismiss];
//        NSURL *url = [NSURL URLWithString:downloadUrl];
//        [[UIApplication sharedApplication] openURL:url];
//      }];
//      [alertView show];
//    }
//  } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//    NSLog(@"检查更新出错，错误信息: %@", error);
//  }];
}

@end
