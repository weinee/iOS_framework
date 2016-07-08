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
#if DEBUG
	[self registFLEX];
#endif
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
	[[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor]  backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagDebug];
	
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	
	/** 默认日志文件保存在cache/log下*/
	DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
	fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
	fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
	[DDLog addLogger:fileLogger];
}

-(void)registApperance{
	/************ 控件外观设置 **************/
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:237/255.0f green:37/255.0f blue:9/255.0f alpha:1]};
	[[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
	[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:237/255.0f green:37/255.0f blue:9/255.0f alpha:1]];
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1]];
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
	
	[[UITabBar appearance] setTintColor:[UIColor colorWithRed:237/255.0f green:37/255.0f blue:9/255.0f alpha:1]];
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:237/255.0f green:37/255.0f blue:9/255.0f alpha:1]} forState:UIControlStateSelected];
	
	[[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1]];
	
	[UISearchBar appearance].tintColor = [UIColor colorWithRed:237/255.0f green:37/255.0f blue:9/255.0f alpha:1];
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
	[[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
	
	UIPageControl *pageControl = [UIPageControl appearance];
	pageControl.pageIndicatorTintColor = [UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1];
	pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
	
	[[UITextField appearance] setTintColor:[UIColor colorWithRed:8/255.0f green:114/255.0f blue:33/255.0f alpha:1]];
	[[UITextView appearance]  setTintColor:[UIColor colorWithRed:8/255.0f green:114/255.0f blue:33/255.0f alpha:1]];
	
	UIMenuController *menuController = [UIMenuController sharedMenuController];
	
	[menuController setMenuVisible:YES animated:YES];
	[menuController setMenuItems:@[
								   [[UIMenuItem alloc] initWithTitle:@"复制" action:NSSelectorFromString(@"copyText:")],
								   [[UIMenuItem alloc] initWithTitle:@"删除" action:NSSelectorFromString(@"deleteObject:")]
								   ]];
}

#if DEBUG
-(void)registFLEX{
	// 在window上添加一个打开flexManager的按钮
	UIButton *openFlexManagerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	openFlexManagerBtn.frame = CGRectMake(0, kScreenHeight - 20, 40, 20);
	[openFlexManagerBtn setTitle:@"FLEX" forState:UIControlStateNormal];
	[openFlexManagerBtn addTarget:self action:@selector(openFlexManager) forControlEvents:UIControlEventTouchUpInside];
	[[UIApplication sharedApplication].keyWindow addSubview:openFlexManagerBtn];
}

-(void) openFlexManager{
	// This could also live in a handler for a keyboard shortcut, debug menu item, etc.
	
	[[FLEXManager sharedManager] showExplorer];
}
#endif

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
