//
//  HYBTextView.m
//  HongTu
//
//  Created by weinee on 16/4/6.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "HYBTextView.h"
@interface HYBTextView () {
	BOOL _shouldDrawPlaceholder;
}

@end
@implementation HYBTextView
#pragma mark - 重写父类方法
- (void)setText:(NSString *)text {
	[super setText:text];
	[self drawPlaceholder];
	return;
}

- (void)setPlaceholder:(NSString *)placeholder {
	if (![placeholder isEqual:_placeholder]) {
		_placeholder = placeholder;
		[self drawPlaceholder];
	}
	return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self configureBase];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self configureBase];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	if (_shouldDrawPlaceholder) {
		[_placeholderTextColor set];
		
		//忽略被遗弃的方法的警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
		[_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,self.frame.size.height - 16.0f) withFont:self.font];
#pragma clang diagnostic pop
//    [_placeholder drawInRect:CGRectMake(8.0f, 8.0f, self.frame.size.width - 16.0f,self.frame.size.height - 16.0f) withAttributes:@{NSFontAttributeName:self.font}];
	}
	return;
}

- (void)configureBase {
	 [[NSNotificationCenter defaultCenter]  addObserver:self
	 selector:@selector(textChanged:)
	 name:UITextViewTextDidChangeNotification
	 object:self];
	
	self.placeholderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
	_shouldDrawPlaceholder = NO;
	return;
}

- (void)drawPlaceholder {
	BOOL prev = _shouldDrawPlaceholder;
	_shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
	
	if (prev != _shouldDrawPlaceholder) {
		[self setNeedsDisplay];
	}
	return;
}

- (void)textChanged:(NSNotification *)notification {
	[self drawPlaceholder];
	return;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
	return;
}

@end
