//
//  WNCustomBoardToolView.m
//  HongTu
//
//  Created by weinee on 16/4/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "WNCustomKeyBoardToolView.h"

@interface WNCustomBoardToolViewModel ()

/** 工具条可以管理的输入框*/
@property (nonatomic, strong) NSArray* modelTextInputViews;

@property (nonatomic, strong) NSArray * modelToolButtons;

@property (nonatomic, assign) CGFloat modelHeight;//高度

@property (nonatomic, strong) UIColor *modelBackgColor;

@property (nonatomic, strong) UIButton *modelFinishBtn;

@property (nonatomic, copy) NSString * modelFinishButtonTittle;

@property (nonatomic, copy) ButtonClick modelToolButtonClick;

@property (nonatomic, copy) FinishButtonClick modelFinishButtonClickBlock;

@property (nonatomic, copy) EndConfig modelEndConfig;

@end

@implementation WNCustomKeyBoardToolView
@synthesize config = _config;

+(instancetype)keyBoardTool{
	WNCustomKeyBoardToolView *view = [[WNCustomKeyBoardToolView alloc] init];
	return view;
}

-(WNCustomBoardToolViewModel *)config{
	if (_config) {
		return _config;
	}
	_config = [[WNCustomBoardToolViewModel alloc] init];
	
	__weak typeof (self) ws = self;
	__strong typeof(ws) strongSelf = ws;
	
	_config.modelEndConfig = ^(){
		//使用config中的内容布局
		[strongSelf doLayoutSubViews];
		return ws;
	};
	return _config;
}

-(void)doLayoutSubViews{
	__block CGFloat spacing = 3;
	
	self.backgroundColor = self.config.modelBackgColor;
	self.frame = CGRectMake(0, 0, kScreenWidth, self.config.modelHeight);

	self.config.modelFinishBtn.frame = CGRectMake(kScreenWidth - self.config.modelHeight - 10, spacing, self.config.modelHeight-2*spacing, self.config.modelHeight-2*spacing);
	[self.config.modelFinishBtn addTarget:self action:@selector(clickFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:self.config.modelFinishBtn];
	
	__weak typeof (self) ws = self;
	[self.config.modelToolButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIButton *btn = obj;
		btn.frame = CGRectMake(idx*(self.config.modelHeight + spacing) + spacing, spacing, self.config.modelHeight - spacing*2, self.config.modelHeight - spacing*2);
		[btn addTarget:ws action:@selector(clickToolsBtn:) forControlEvents:UIControlEventTouchUpInside];
		[ws addSubview:btn];
	}];
	
}

/** 获取当前正在使用的输入框*/
-(id)getCurrentTextView{
	for (id currentTextView in self.config.modelTextInputViews) {
		if ([currentTextView isFirstResponder]) {
			return currentTextView;
		}
	}
	return nil;
}
/** 获取当前正在使用的输入框下标, 返回-1是表示没有正在使用的输入框*/
-(NSInteger)getCurrentTextViewIndex{
	for (NSInteger i=0; i<self.config.modelTextInputViews.count; i++) {
		if ([self.config.modelTextInputViews[i] isFirstResponder]) {
			return i;
		}
	}
	return -1;
}


#pragma mark finish button click
-(void)clickFinishBtn:(UIButton *)sender{
	if (self.config.modelFinishButtonClickBlock) {
		self.config.modelFinishButtonClickBlock(self.config.modelTextInputViews, [self getCurrentTextViewIndex]);
	}
}

#pragma mark tools button click
-(void)clickToolsBtn:(UIButton *)sender{
	if (self.config.modelToolButtonClick) {
		self.config.modelToolButtonClick(sender, [self.config.modelToolButtons indexOfObject:sender], self.config.modelTextInputViews, [self getCurrentTextViewIndex]);
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation WNCustomBoardToolViewModel

- (instancetype)init
{
	self = [super init];
	if (self) {
		/** 默认值*/
		_modelHeight = 40.0;
		
		UIButton *toolBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[toolBtn1 setBackgroundImage:[UIImage imageNamed:@"Addr_alreadyFocus"] forState:UIControlStateNormal];
//		[toolBtn1 setImage:[UIImage imageNamed:@"Addr_alreadyFocus"] forState:UIControlStateNormal];
		
		UIButton *toolBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[toolBtn2 setBackgroundImage:[UIImage imageNamed:@"Addr_addFocus"] forState:UIControlStateNormal];
//		[toolBtn2 setImage:[UIImage imageNamed:@"Addr_addFocus"] forState:UIControlStateNormal];
		
		_modelToolButtons = @[toolBtn1, toolBtn2];
		
//		_modelBackgColor = [UIColor whiteColor];
		_modelBackgColor = kColorGray;
		
		_modelFinishButtonTittle = @"";
		
		_modelFinishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_modelFinishBtn setTitle:_modelFinishButtonTittle forState:UIControlStateNormal];
		[_modelFinishBtn setBackgroundImage:[UIImage imageNamed:@"packup_keyboard"] forState:UIControlStateNormal];
		_modelFinishBtn.tintColor = [UIColor blackColor];
		
		_modelFinishButtonClickBlock = ^(NSArray *textInputViews, NSInteger currentInputViewIndex){
			if ([textInputViews[currentInputViewIndex] isFirstResponder]) {
				[textInputViews[currentInputViewIndex] resignFirstResponder];
				if (currentInputViewIndex + 1 < textInputViews.count) {
					[textInputViews[currentInputViewIndex + 1] becomeFirstResponder];
				}
			}
		};
		
		_modelToolButtonClick = ^(UIButton *currentBtn, NSInteger btnIndex, NSArray *textInputViews, NSInteger currentInputViewIndex){
			if (btnIndex >1 || btnIndex <0) {
				return ;
			}
			if ((btnIndex == 0 && currentInputViewIndex <= 0) || (btnIndex == 1 && currentInputViewIndex >= textInputViews.count - 1)) {
				[textInputViews[currentInputViewIndex] resignFirstResponder];
				return ;
			}
			if ([textInputViews[currentInputViewIndex] isFirstResponder]) {
				[textInputViews[currentInputViewIndex] resignFirstResponder];
				if (btnIndex == 0) {
					[textInputViews[currentInputViewIndex - 1] becomeFirstResponder];
				} else {
					[textInputViews[currentInputViewIndex + 1] becomeFirstResponder];
				}
			}
		};
	}
	return self;
}

#pragma mark 设置项
-(ArrayToModel)textInputViews{
	__weak typeof (self) ws = self;
	return ^(NSArray *arr){
		_modelTextInputViews = arr;
		return ws;
	};
}

-(ArrayToModel)toolButtons{
	__weak typeof (self) ws = self;
	return ^(NSArray *arr){
		_modelToolButtons = arr;
		return ws;
	};
}

-(ButtonClickBlockToModel)toolButtonClick{
	__weak typeof (self) ws = self;
	return ^(ButtonClick buttonClickBlock){
		_modelToolButtonClick = buttonClickBlock;
		return ws;
	};
}

-(FloatToModel)height{
	__weak typeof (self) ws = self;
	return ^(CGFloat num){
		_modelHeight = num;
		return ws;
	};
}

-(StringToModel)finishButtonTittle{
	__weak typeof (self) ws = self;
	return ^(NSString *str){
		_modelFinishButtonTittle = str;
		return ws;
	};
}

-(FinishButtonBlockToModel)finishButtonClickBlock{
	__weak typeof (self) ws = self;
	return ^(FinishButtonClick finishButtonClick){
		_modelFinishButtonClickBlock = finishButtonClick;
		return ws;
	};
}

-(ColorToModel)backgColor{
	__weak typeof (self) ws = self;
	return ^(UIColor *color){
		_modelBackgColor = color;
		return ws;
	};
}

-(EndConfig)endConfig{
	__weak typeof (self) ws = self;
	return ^(){
		return ws.modelEndConfig();
	};
}

@end
