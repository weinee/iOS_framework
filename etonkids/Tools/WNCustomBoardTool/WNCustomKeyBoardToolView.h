//
//  WNCustomBoardToolView.h
//  HongTu
//
//  Created by weinee on 16/4/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WNCustomBoardToolViewModel, WNCustomKeyBoardToolView;

typedef void(^FinishButtonClick)(NSArray *textInputViews, NSInteger currentInputViewIndex);
typedef void(^ButtonClick)(UIButton *currentBtn, NSInteger btnIndex, NSArray *textInputViews, NSInteger currentInputViewIndex);

typedef WNCustomBoardToolViewModel *(^ArrayToModel)(NSArray *arr);
typedef WNCustomBoardToolViewModel *(^FloatToModel)(CGFloat num);
typedef WNCustomBoardToolViewModel *(^StringToModel)(NSString *str);
typedef WNCustomBoardToolViewModel *(^ColorToModel)(UIColor *color);
//typedef WNCustomBoardToolViewModel *(^FontToModel)(UIFont *font);

typedef WNCustomBoardToolViewModel *(^FinishButtonBlockToModel)(FinishButtonClick finishButtonClick);

typedef WNCustomBoardToolViewModel *(^ButtonClickBlockToModel)(ButtonClick buttonClick);

typedef WNCustomKeyBoardToolView *(^EndConfig)();


@interface WNCustomKeyBoardToolView : UIView

@property (nonatomic, strong, readonly) WNCustomBoardToolViewModel* config;

+(instancetype) keyBoardTool;

@end

@interface WNCustomBoardToolViewModel : NSObject

/** 工具条可以管理的输入框*/
@property (nonatomic, copy, readonly) ArrayToModel textInputViews;

/** 一下两个要同时设置，要么都不设置*/
@property (nonatomic, copy, readonly) ArrayToModel toolButtons;

@property (nonatomic, copy, readonly) ButtonClickBlockToModel toolButtonClick;

@property (nonatomic, copy, readonly) FloatToModel height;//高度

@property (nonatomic, copy, readonly) ColorToModel backgColor;

@property (nonatomic, copy, readonly) StringToModel finishButtonTittle;

@property (nonatomic, copy, readonly) FinishButtonBlockToModel finishButtonClickBlock;

@property (nonatomic, copy, readonly) EndConfig endConfig;

@end
