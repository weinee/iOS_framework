//
//  RegistViewController.m
//  etonkids
//
//  Created by weineeL on 16/6/29.
//  Copyright © 2016年 ytdinfo. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

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
- (IBAction)cancelRegist:(id)sender {
	[self dismissViewControllerAnimated:YES completion:^{
		//TODO: 登录
		DDLogWarn(@"登录");
	}];
}


#pragma mark - private

#pragma mark - getter / setter

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
