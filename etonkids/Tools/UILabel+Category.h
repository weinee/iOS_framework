//
//  UILabel+Category.h
//  HongTu
//
//  Created by 胡凌 on 16/5/4.
//  Copyright © 2016年 Facebook. All rights reserved.
//
//UILabel自适应大小
#import <UIKit/UIKit.h>

@interface UILabel (Category)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
