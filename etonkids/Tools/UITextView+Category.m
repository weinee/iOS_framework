//
//  UITextView+Category.m
//  HongTu
//
//  Created by 胡凌 on 16/5/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Category)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
  UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
  label.text = title;
  label.font = font;
  [label sizeToFit];
  CGFloat height = label.frame.size.height;
  return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
  UITextView *label = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
  label.text = title;
  label.font = font;
  [label sizeToFit];
  return label.frame.size.width;
}
@end
