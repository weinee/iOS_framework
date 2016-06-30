//
//  FGStepBaseViewController.m
//  etonkids
//
//  Created by weineeL on 16/6/30.
//  Copyright © 2016年 ytdinfo. All rights reserved.
//

#import "FGStepBaseViewController.h"
#import "ForgetPwdNavigationController.h"

@interface FGStepBaseViewController ()

@end

@implementation FGStepBaseViewController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self initNavigationBar];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action
- (void)cancelModifyPwd:(id)sender {
	
	[self.navigationController dismissViewControllerAnimated:YES completion:^{
		
	}];
}

#pragma mark - private
-(void)initNavigationBar{
	self.navigationItem.title = @"重置密码";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_close"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelModifyPwd:)];
	
}

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
