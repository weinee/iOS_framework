//
//  MBHttpProgressHUD.h
//  eOrder
//
//  Created by jason on 14-8-12.
//  Copyright (c) 2014年 ytd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBHttpProgressHUD : NSObject

+ (void)fadeOutHUDInView:(UIView *)view withSuccessText:(NSString *)text;

+(void) processBeginInView:(UIView*)view title:(NSString*)title;
+(void) processFinishInView:(UIView*)view title:(NSString*) title complete:(void(^)(void))complete;
+(void) processErrorInView:(UIView*)view complete:(void(^)(void))complete;

+(void) processBeginInView:(UIView*)view;
+(void) processSuccessInView:(UIView*)view complete:(void(^)(void))complete;
+(void) processFailInView:(UIView*)view complete:(void(^)(void))complete;
+(void) processSuccessInViewWithOutHUD:(UIView *)view complete:(void(^)(void))complete;

+(void) loadDataBeginInView:(UIView*)view;
+(void) loadDataSuccessInView:(UIView*)view complete:(void(^)(void))complete;
+(void) loadDataFailInView:(UIView*)view complete:(void(^)(void))complete;

@end
