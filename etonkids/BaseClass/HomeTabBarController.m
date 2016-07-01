//
//  HomeTabBarController.m
//  etonkids
//
//  Created by weineeL on 16/6/29.
//  Copyright © 2016年 ytdinfo. All rights reserved.
//

#import "HomeTabBarController.h"
#import "HPMainViewController.h"
#import "MEMainViewController.h"
#import "MSMainViewController.h"
#import "BaseNavigationViewController.h"

@interface HomeTabBarController ()

@property (nonatomic, strong) NSArray <UIViewController *> *subViewControllers;

@property (nonatomic, copy) NSArray <NSString *> *storyboardNames;

@end

@implementation HomeTabBarController
#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action
-(void)setupViewControllers{
	[self setViewControllers:self.subViewControllers];
}
#pragma mark - private

#pragma mark - getter / setter
+(NSString *)storyboardId{
	return @"HomeTabBarController";
}

-(NSArray<UIViewController *> *)subViewControllers{
	if (_subViewControllers) {
		return _subViewControllers;
	}
	NSMutableArray *marr = [NSMutableArray arrayWithCapacity:self.storyboardNames.count];
	for (NSString *storyboardName in self.storyboardNames) {
		[marr addObject:[[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateInitialViewController]];
	}
	_subViewControllers = [marr copy];
	return _subViewControllers;
}

-(NSArray<NSString *> *)storyboardNames{
	if (_storyboardNames) {
		return _storyboardNames;
	}
	_storyboardNames = @[@"HomePage", @"MoreService", @"Me"];
	return _storyboardNames;
}

#pragma mark - layoutSubviews


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
