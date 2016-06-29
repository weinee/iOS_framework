//
//  DropMenuView.h
//  HongTu
//
//  Created by liucong on 16/3/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropMenuView : UIView
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go;
+ (void)removed;

@end
