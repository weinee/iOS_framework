//
//  BaseViewController.h
//  YPB-TG
//
//  Created by weineeL on 16/6/25.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryboardIdProtocol.h"
#import "HomeTabBarView.h"

@interface BaseViewController : UIViewController <StoryboardIdProtocol>

@property (nonatomic, strong) HomeTabBarView *homeTabBarView;

@property (nonatomic, assign) BOOL hiddenTabBarView;

@end
