//
//  HomeTabBarItem.h
//  HongTu
//
//  Created by sunshine on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeTabBarItem;

@class HomeTabBarView;


@protocol HomeTabBarItemDelegate <NSObject>

-(void)homeTabBarItem:(HomeTabBarItem*) tabBarItem touchedIndex:(NSInteger) index;
@optional
-(void)sycnBadgeItemWithValue:(NSString *)stringValue;

@end

@interface HomeTabBarItem : UIView

@property (nonatomic, strong)UIImageView* imageView;
@property (nonatomic, strong)UILabel* labelTitle;
@property (nonatomic,strong) UILabel *badgeView;
@property (nonatomic) Boolean selected;

-(instancetype)initWithFrame:(CGRect)frame andSelectedImage:(UIImage *)seletctedImage unSelectedImage:(UIImage *) unSelectedImage andTitle:(NSString *) title;

@end

@interface HomeTabBarView : UIView

@property (nonatomic, strong) NSArray<HomeTabBarItem *> * items;

-(instancetype)initWithDelegate:(id<HomeTabBarItemDelegate>) delegate andSelectedImages:(NSArray <UIImage *> *)selectedImages unSelectedImages:(NSArray <UIImage *> *) unSelectedImages titles:(NSArray<NSString *>*) titles;
-(void)selectIndex:(int)tabIndex;

-(void)setupUI;
@property id<HomeTabBarItemDelegate> delegate ;

-(void)sycnMessageBadgeItemWithValue:(NSString *)stringValue;


@end
