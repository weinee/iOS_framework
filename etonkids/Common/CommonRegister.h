//
//  CommonRegister.h
//  YPB-TG
//
//	应用全局设置
//
//  Created by weineeL on 16/6/25.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 日志框架*/
#import <CocoaLumberjack/CocoaLumberjack.h>
//根据情况开启不同的级别
#ifdef DEBUG
#import "FLEXManager.h"
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarn;
#endif

/** 网络请求*/
#import "AFNetworkReachabilityManager.h"

/** 代码块*/
typedef void(^NetwordReachability)(AFNetworkReachabilityStatus status);



@interface CommonRegister : NSObject

/** 网络状态改变时的回调, 单例中的回调*/
@property (nonatomic, copy) NetwordReachability networkReachability;

+(instancetype)shareRegister;//单例

/** 模板方法*/
-(void)templateRegist;

/** 当前的网络状态*/
-(AFNetworkReachabilityStatus) currentNetworkStatus;

/** 注册网络状态检测的通知*/
-(void)registReachabilityNotify;

/** 注册，初始化日志框架CocoaLumberjack*/
-(void)registCocoaLumberjackLog;

/** 统一样式*/
-(void)registApperance;

#if DEBUG
-(void)registFLEX;
#endif

@end
