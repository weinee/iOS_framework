//
//  UILabel+Category.m
//  HongTu
//
//  Created by 胡凌 on 16/5/4.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
  label.text = title;
  label.font = font;
  label.numberOfLines = 0;
  [label sizeToFit];
  CGFloat height = label.frame.size.height;
  return height;
}

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
  label.text = title;
  label.font = font;
  [label sizeToFit];
  return label.frame.size.width;
}
@end
