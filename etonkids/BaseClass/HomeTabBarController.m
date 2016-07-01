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

@end

@implementation HomeTabBarController
#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	DDLogInfo(@"%@", self.viewControllers);
	DDLogInfo(@"%@", self.tabBar.items);
	[self setupViewControllers];
	DDLogInfo(@"%@", self.viewControllers);
	DDLogInfo(@"%@", self.tabBar.items);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action
-(void)setupViewControllers{
	NSMutableArray *marr = [NSMutableArray arrayWithCapacity:self.subViewControllers.count];
	for (UIViewController *controller in self.subViewControllers) {
		[marr addObject:[[BaseNavigationViewController alloc] initWithRootViewController:controller]];
	}
	[self setViewControllers:[marr copy]];
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
	_subViewControllers = @[[[HPMainViewController alloc] init], [[MEMainViewController alloc] init], [[MSMainViewController alloc] init]];
	return _subViewControllers;
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
