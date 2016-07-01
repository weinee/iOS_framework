//
//  HomeTabBarItem.m
//  HongTu
//
//  Created by sunshine on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//	Modified by weineeL
//

#import "HomeTabBarView.h"

@interface HomeTabBarItem(){
	UIImage *_selectedImage;
	UIImage *_unSelectedImage;
}

@end

@implementation HomeTabBarItem

-(instancetype)initWithFrame:(CGRect)frame andSelectedImage:(UIImage *)seletctedImage unSelectedImage:(UIImage *)unSelectedImage andTitle:(NSString *)title{
  self = [super initWithFrame:frame];
  if(self){
	  _selectedImage = seletctedImage;
	  _unSelectedImage = unSelectedImage;
	  self.labelTitle.text = title;
    [self setupUI];
  }
	
  return self;
}

-(void)setupUI{

  [self addSubview:self.badgeView];
  [self addSubview:self.imageView];
  [self addSubview:self.labelTitle];

}



-(void)sycnBadgeItemWithValue:(NSString *)stringValue{
  self.badgeView.text = stringValue;
  self.badgeView.hidden = NO;
  self.badgeView.backgroundColor = kColorRed;
  if ([self.badgeView.text isEqualToString:@"0"]) {
    self.badgeView.text = @"";
    self.badgeView.hidden = YES;
    self.badgeView.backgroundColor = [UIColor clearColor];
  }
}

#pragma mark setter/getter
-(UIImageView *)imageView{
	if (_imageView) {
		return _imageView;
	}
	 _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-22)/2, 4, 22, 22)];
	return _imageView;
}

-(UILabel *)labelTitle{
	if (_labelTitle) {
		return _labelTitle;
	}
	_labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 12)];
	_labelTitle.font = kFontOfSize(11);
	_labelTitle.textColor = kColorTextDetailDeeper;
	_labelTitle.textAlignment = NSTextAlignmentCenter;
	return _labelTitle;
}

-(UILabel *)badgeView{
	if (_badgeView) {
		return _badgeView;
	}
	self.badgeView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame), 4, 14, 14)];
	self.badgeView.font = kFontOfSize(10);
	self.badgeView.layer.cornerRadius = 7;
	self.badgeView.layer.masksToBounds = YES;
	
	self.badgeView.text = @(0).stringValue;
	self.badgeView.textAlignment = NSTextAlignmentCenter;
	if ([self.badgeView.text isEqualToString:@"0"]) {
		self.badgeView.text = @"";
		self.badgeView.backgroundColor = [UIColor clearColor];
	}else{
		self.badgeView.backgroundColor = kColorRed;
	}
	self.badgeView.hidden = YES;
	self.badgeView.textColor = [UIColor whiteColor];
	return _badgeView;
}

-(void)setSelected:(Boolean)selected{
	_selected = selected;
	if (_selected) {
		self.imageView.image = _selectedImage;
		self.labelTitle.textColor = kColorRed;
	} else{
		self.imageView.image = _unSelectedImage;
		self.labelTitle.textColor = kColorTextDetailDeeper;
	}
}

@end


@interface HomeTabBarView(){
  NSArray<UIImage *> *_arrayUnselected;
  NSArray<UIImage *> *_arraySelected;
	NSArray<NSString *> *_arrayTitles;
}

@end

@implementation HomeTabBarView

-(instancetype)initWithDelegate:(id<HomeTabBarItemDelegate>) delegate andSelectedImages:(NSArray<UIImage *> *)selectedImages unSelectedImages:(NSArray<UIImage *> *)unSelectedImages titles:(NSArray<NSString *> *)titles{
	self = [super init];
	if(self){
		self.delegate = delegate;
		self.frame = CGRectMake(0, 0, kScreenWidth, 49);
    
		_arrayUnselected = unSelectedImages;
		_arraySelected = selectedImages;
		_arrayTitles = titles;
		
		NSMutableArray *marr = [NSMutableArray arrayWithCapacity:_arraySelected.count];
		CGFloat width = kScreenWidth / _arraySelected.count;
		for (int i=0; i<_arraySelected.count; i++) {
			HomeTabBarItem *item = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(i*width, 0, width, 49) andSelectedImage:_arraySelected[i] unSelectedImage:_arrayUnselected[i] andTitle:_arrayTitles[i]];
			item.tag = i + 1;
			item.selected = false;
			
			UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
			[item addGestureRecognizer:singleTapGestureRecognizer];
			
			[marr addObject:item];
			[self addSubview:item];
		}
		self.items = [marr copy];
		[self setupUI];
	}
	return self;
}

-(void)sycnMessageBadgeItemWithValue:(NSString *)stringValue{
//  [item1 sycnBadgeItemWithValue:stringValue];
}

-(void)setupUI{
  
  UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5f)];
  sep.backgroundColor = kColorSplitLine;
  [self addSubview:sep];
  
  
//  UIButton* btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
//  btnCenter.frame =  CGRectMake((self.frame.size.width-66)/2, -16, 66, 66);
//  [btnCenter setBackgroundImage:[UIImage imageNamed:@"tab_icon_home"] forState:UIControlStateNormal];
//  [btnCenter setBackgroundImage:[UIImage imageNamed:@"tab_icon_home"] forState:UIControlStateHighlighted];
//  [self addSubview:btnCenter];
//  
//  [btnCenter addTarget:self action:@selector(btnCenter_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
	
}

-(void)selectIndex:(int)tabIndex{
	for (UIView *subView in self.subviews) {
		if ([subView isKindOfClass:[HomeTabBarItem class]]) {
			HomeTabBarItem *item = (HomeTabBarItem *)subView;
			if (item.selected && item.tag != tabIndex + 1) {
				item.selected = false;
			}
			if (item.tag == tabIndex + 1) {
				item.selected = true;
			}
		}
	}
}

//-(void)btnCenter_TouchUpInside:(UIButton*)sender{
//  if(self.delegate && [self.delegate respondsToSelector:@selector(homeTabBarItem:touchedIndex:)]){
//    [self.delegate homeTabBarItem:item3 touchedIndex:item3.tag];
//  }
//}

-(void)touchUpInside_gesture:(UIGestureRecognizer*)sender{
  HomeTabBarItem* item = (HomeTabBarItem*)sender.view;
  if(self.delegate && [self.delegate respondsToSelector:@selector(homeTabBarItem:touchedIndex:)]){
    [self.delegate homeTabBarItem:item touchedIndex:item.tag];
  }
}

#pragma mark setter/getter


@end
