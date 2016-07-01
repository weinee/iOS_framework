//
//  BaseViewController.m
//  YPB-TG
//
//  Created by weineeL on 16/6/25.
//  Copyright © 2016年 weinee. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSArray <NSString *> *selectedImages;

@property (nonatomic, strong) NSArray <NSString *> *unSelectedImages;

@end

@implementation BaseViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action

#pragma mark - private

#pragma mark - getter / setter
+(NSString *)storyboardId{
	return @"BaseViewController";
}

-(NSArray<NSString *> *)selectedImages{
	if (_selectedImages) {
		return _selectedImages;
	}
	_selectedImages = @[@"icon_menu_home1", @"icon_menu_more1", @"icon_menu_me1"];
	return _selectedImages;
}

-(NSArray<NSString *> *)unSelectedImages{
	if (_unSelectedImages) {
		return _unSelectedImages;
	}
	_unSelectedImages = @[@"icon_menu_home0", @"icon_menu_more0", @"icon_menu_me0"];
	return _unSelectedImages;
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
