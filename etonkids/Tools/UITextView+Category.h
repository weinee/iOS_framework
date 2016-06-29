//
//  UITextView+Category.h
//  HongTu
//
//  Created by 胡凌 on 16/5/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Category)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
