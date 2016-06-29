//
//  MBHttpProgressHUD.m
//  eOrder
//
//  Created by jason on 14-8-12.
//  Copyright (c) 2014年 ytd. All rights reserved.
//

#import "MBHttpProgressHUD.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+CustomAdditions.h"

@implementation MBHttpProgressHUD

+ (void)fadeOutHUDInView:(UIView *)view withSuccessText:(NSString *)text {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    
    [self performBlock:^{
        [MBProgressHUD hideHUDForView:view animated:YES];
    } afterDelay:1.0];
}

+(void) processBeginInView:(UIView*)view title:(NSString*)title{
    [MBProgressHUD fadeInHUDInView:view withText:title];
}
+(void) processFinishInView:(UIView*)view title:(NSString*) title complete:(void(^)(void))complete {
    if(title==nil || title.length==0){
        [MBProgressHUD hideHUDForView:view animated:NO];
    }else {
        [MBProgressHUD fadeOutHUDInView:view withSuccessText:title];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(complete) complete();
}
+(void) processErrorInView:(UIView*)view complete:(void(^)(void))complete{
    [MBProgressHUD hideHUDForView:view animated:NO];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(complete) complete();
}


+(void) processBeginInView:(UIView*)view{
    [MBHttpProgressHUD processBeginInView:view title:@"处理中..."];
}
+(void) processSuccessInView:(UIView*)view complete:(void(^)(void))complete{
    [MBHttpProgressHUD processFinishInView:view title:@"处理完成!" complete:complete];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
+(void) processFailInView:(UIView*)view complete:(void(^)(void))complete{
    [MBHttpProgressHUD processErrorInView:view complete:complete];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
+(void) processSuccessInViewWithOutHUD:(UIView *)view complete:(void(^)(void))complete{
    [MBProgressHUD hideHUDForView:view animated:NO];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(complete) complete();
}

+(void) loadDataBeginInView:(UIView*)view{
    [MBHttpProgressHUD processBeginInView:view title:@"数据加载中..."];
}
+(void) loadDataSuccessInView:(UIView*)view complete:(void(^)(void))complete{
    [MBProgressHUD hideHUDForView:view animated:NO];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if(complete) complete();
}

+(void) loadDataFailInView:(UIView*)view complete:(void(^)(void))complete{
    [MBHttpProgressHUD processErrorInView:view complete:complete];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
