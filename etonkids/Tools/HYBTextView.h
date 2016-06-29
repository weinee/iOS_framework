//
//  HYBTextView.h
//  HongTu
//
//  Created by weinee on 16/4/6.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBTextView : UITextView
/*!
 * @brief 占位符文本,与UITextField的placeholder功能一致
 */
@property (nonatomic, strong) NSString *placeholder;

/*!
 * @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;
@end
