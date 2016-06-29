//
//  UIImage+HeadImage.h
//  HongTu
//
//  Created by liucong on 16/3/24.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HeadImage)
//取颜色color背景图片
+ (UIImage *)imageFormColor:(UIColor *)color frame:(CGRect)frame;


/**
 *  带居中文字的图片
 *
 *  @param title    文字
 *  @param fontSize 文字大小
 *
 *  @return
 */
- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;

+ (UIImage *)creatAvatarWithUsername:(NSString *) username frame:(CGRect)frame backColor:(UIColor *) color fontSize:(CGFloat) fontSize;
@end
