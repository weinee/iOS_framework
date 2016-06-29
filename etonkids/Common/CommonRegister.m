//
//  CommonRegister.m
//  YPB-TG
//
//  Created by weineeL on 16/6/25.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import "CommonRegister.h"

@implementation CommonRegister

static CommonRegister *sharedRegister;

+(instancetype)shareRegister{
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		sharedRegister=[[self alloc] init];
	});
	return sharedRegister;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		sharedRegister = [super allocWithZone:zone];
	});
	return sharedRegister;
}

+ (id)copyWithZone:(struct _NSZone *)zone{
	return sharedRegister;
}

-(void)templateRegist{
	[self registCocoaLumberjackLog];
	[self registReachabilityNotify];
	[self registApperance];
}

-(AFNetworkReachabilityStatus)currentNetworkStatus{
	return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

-(void)registReachabilityNotify{
	__weak typeof (self) ws = self;
	[[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (ws.networkReachability) {
			ws.networkReachability(status);
		}
	}];
	[[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

-(void)registCocoaLumberjackLog{
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor whiteColor]  backgroundColor:[UIColor blackColor] forFlag:DDLogFlagDebug];
	
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	
	/** 默认日志文件保存在cache/log下*/
	DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
	fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
	fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
	[DDLog addLogger:fileLogger];
}

-(void)registApperance{
	
}

#pragma mark getter/setter
-(NetwordReachability)networkReachability{
	if (_networkReachability) {
		return _networkReachability;
	}
	// 默认的网络状态改变回调方法
	return ^(AFNetworkReachabilityStatus status) {
		DDLogDebug(@"网络状态: %ld", status);
		// 当网络状态改变时做一些全局的事情
	};
}

@end
