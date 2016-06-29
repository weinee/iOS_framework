//
//  UIImage+HeadImage.m
//  HongTu
//
//  Created by liucong on 16/3/24.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UIImage+HeadImage.h"

@implementation UIImage (HeadImage)


+ (UIImage *)creatAvatarWithUsername:(NSString *)username frame:(CGRect)frame backColor:(UIColor *)color fontSize:(CGFloat)fontSize{
	return [[UIImage imageFormColor:color frame:frame] imageWithTitle:username fontSize:fontSize];
}

+ (UIImage *)imageFormColor:(UIColor *)color frame:(CGRect)frame{
  CGRect rect=CGRectMake(0, 0, frame.size.width, frame.size.height);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context=UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
  
 // CGContextRelease(context);
  UIGraphicsEndImageContext();
  return image;
}

- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize {
  //画布大小
  CGSize size=CGSizeMake(self.size.width,self.size.height);
  //创建一个基于位图的上下文
  UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
  
  [self drawAtPoint:CGPointMake(0.0,0.0)];
  
  //文字居中显示在画布上
  NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
  paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
  
  //计算文字所占的size,文字居中显示在画布上
  CGSize sizeText=[title boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:kFontOfSize(fontSize)}context:nil].size;
  CGFloat width = self.size.width;
  CGFloat height = self.size.height;
  
  CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
  //绘制文字
  [title drawInRect:rect withAttributes:@{ NSFontAttributeName:kFontOfSize(fontSize),NSForegroundColorAttributeName:[ UIColor whiteColor],NSParagraphStyleAttributeName:paragraphStyle}];
  
  //返回绘制的新图形
  UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}
@end
