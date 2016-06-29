//
//  ForgetPwdNavigationController.m
//  etonkids
//
//  Created by weineeL on 16/6/29.
//  Copyright © 2016年 ytdinfo. All rights reserved.
//

#import "ForgetPwdNavigationController.h"

@interface ForgetPwdNavigationController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation ForgetPwdNavigationController

#pragma mark - def

#pragma mark - override
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelModifyPwd:)];
	self.navigationItem.rightBarButtonItem = right;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - api

#pragma mark - model event

#pragma mark - view event & action
-(void)cancelModifyPwd:(UIBarButtonItem *) item{
	[self dismissViewControllerAnimated:YES completion:^{
		//TODO: 如果成功修改，则直接登录，否知什么都不做;
		DDLogWarn(@"%@", @"如果成功修改，则直接登录，否知什么都不做");
	}];
}
#pragma mark - private

#pragma mark - getter / setter

#pragma mark - layoutSubviews



@end
