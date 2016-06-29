//
//  UIView+animateTextField.h
//  TKClub
//
//  Created by 费惠 on 15/10/20.
//  Copyright (c) 2015年 weinee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum AnimateTextFieldDirect {
	AnimateTextFieldDirectIdentity,//恢复
	AnimateTextFieldDirectUp,
	AnimateTextFieldDirectDown
}AnimateTextFieldDirect;

@interface UIView (animateTextField)
/**
 *   动画  用于视图上移
 *
 *
 *  @param view             需要移动的视图
 *  @param up               yes 上移    no返回
 *  @param movementDistance 上移距离
 */
- (void) animateView:(UIView *)view up: (BOOL) up movementDistance:(CGFloat)movementDistance;

/**
 *  按照方向移动视图
 *
 *  @param view             要移动的视图
 *  @param direction        方向
 *  @param movementDistance 移动的距离
 */
+ (void) animateView:(UIView *)view direction: (AnimateTextFieldDirect)direction movementDistance:(CGFloat)movementDistance;
@end
