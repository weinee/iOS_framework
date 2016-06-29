//
//  UIView+animateTextField.m
//  TKClub
//
//  Created by 费惠 on 15/10/20.
//  Copyright (c) 2015年 weinee. All rights reserved.
//

#import "UIView+animateTextField.h"

@implementation UIView (animateTextField)
- (void) animateView:(UIView *)view up: (BOOL) up movementDistance:(CGFloat)movementDistance
{
    const int txtMovementDistance=movementDistance;
    const float movementDuration = 0.3f;
    int movement = (up ? -txtMovementDistance : txtMovementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    view.frame = CGRectOffset(view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (void) animateView:(UIView *)view direction: (AnimateTextFieldDirect)direction movementDistance:(CGFloat)movementDistance
{
    const CGFloat txtMovementDistance=ABS(movementDistance);
    const float movementDuration = 0.3f;
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    switch (direction) {
        case AnimateTextFieldDirectDown:
            view.transform = CGAffineTransformMakeTranslation(0, txtMovementDistance);
            break;
        case AnimateTextFieldDirectIdentity:
            view.transform = CGAffineTransformIdentity;
            break;
        case AnimateTextFieldDirectUp:
            view.transform = CGAffineTransformMakeTranslation(0, -txtMovementDistance);
            break;
        default:
            break;
    }
    [UIView commitAnimations];
}
@end
