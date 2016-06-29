//
//  SegmentedView.h
//  HongTu
//
//  Created by liucong on 16/3/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentedControlDelegate < NSObject>

@optional

-(void)segumentSelectionChange:(NSInteger)selection;

@end

@interface SegmentedView : UIView
@property (nonatomic, strong) id <SegmentedControlDelegate> delegate;
@property (nonatomic, strong) NSMutableArray * btnTitleSource;
@property (strong, nonatomic) UIColor * titleColor;
@property (strong, nonatomic) UIColor * selectColor;
@property (strong, nonatomic) UIFont * titleFont;
@property (nonatomic, strong) UIColor * buttonDownColor;
@property (nonatomic, assign) NSInteger selectSeugment;
@property (nonatomic,assign)BOOL canChange;

+ (SegmentedView *)SegmentedViewFrame:(CGRect)frame titleDataSource:(NSArray *)titleDataSouece backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont selectColor:(UIColor *)selectColor buttonDownColor:(UIColor *)buttonDownColor Delegate:(id)delegate;
/** 代码切换*/
-(void)selectTheSegument:(NSInteger)segument;
@end
