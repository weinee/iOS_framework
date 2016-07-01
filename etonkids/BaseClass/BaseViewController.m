//
//  BaseViewController.m
//  YPB-TG
//
//  Created by weineeL on 16/6/25.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <HomeTabBarItemDelegate>

@property (nonatomic, strong) NSArray <UIImage *> *selectedImages;

@property (nonatomic, strong) NSArray <UIImage *> *unSelectedImages;

@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation BaseViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	self.hiddenTabBarView = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self updateViewConstraints];
}

-(void)updateViewConstraints{
	if (!self.hiddenTabBarView) {
		[self.view addSubview:self.homeTabBarView];
		__weak typeof (self) ws = self;
		[self.homeTabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(ws.view.mas_left).offset(0);
			make.right.equalTo(ws.view.mas_right).offset(0);
			make.bottom.equalTo(ws.view.mas_bottom).offset(0);
			make.height.mas_equalTo(49);
		}];
	}
	
	[super updateViewConstraints];
}

#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action
#pragma mark HomeTabBarItemDelegate
-(void)homeTabBarItem:(HomeTabBarItem *)tabBarItem touchedIndex:(NSInteger)index{
	if (index == self.tabBarController.selectedIndex) {
		return;
	}
	BaseViewController *controller = (BaseViewController *)(((UINavigationController *)self.tabBarController.viewControllers[index]).visibleViewController);
	[controller.homeTabBarView selectAtIndex:index];
	self.tabBarController.selectedIndex = index;
}

#pragma mark - private

#pragma mark - getter / setter
+(NSString *)storyboardId{
	return @"BaseViewController";
}

-(NSArray<UIImage *> *)selectedImages{
	if (_selectedImages) {
		return _selectedImages;
	}
	_selectedImages = @[[UIImage imageNamed:@"icon_menu_home1"], [UIImage imageNamed: @"icon_menu_more1"], [UIImage imageNamed:@"icon_menu_me1"]];
	return _selectedImages;
}

-(NSArray<UIImage *> *)unSelectedImages{
	if (_unSelectedImages) {
		return _unSelectedImages;
	}
	_unSelectedImages =@[[UIImage imageNamed:@"icon_menu_home0"], [UIImage imageNamed: @"icon_menu_more0"], [UIImage imageNamed:@"icon_menu_me0"]];
	return _unSelectedImages;
}

-(NSArray<NSString *> *)titles{
	if (_titles) {
		return _titles;
	}
	_titles = @[@"Etonkids", @"更多服务", @"我的"];
	return _titles;
}

-(HomeTabBarView *)homeTabBarView{
	if (_homeTabBarView) {
		return _homeTabBarView;
	}
	_homeTabBarView = [[HomeTabBarView alloc] initWithDelegate:self andSelectedImages:self.selectedImages unSelectedImages:self.unSelectedImages titles:self.titles];
	return _homeTabBarView;
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
