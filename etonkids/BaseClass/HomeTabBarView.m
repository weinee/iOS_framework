//
//  HomeTabBarItem.m
//  HongTu
//
//  Created by sunshine on 16/3/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "HomeTabBarView.h"

@interface HomeTabBarItem()
@end

@implementation HomeTabBarItem

-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if(self){
    [self setupUI];
  }
	
  return self;
}

-(void)setupUI{
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-22)/2, 4, 22, 22)];
  self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.frame.size.width, 12)];
  self.labelTitle.font = kFontOfSize(11);
  self.labelTitle.textColor = kColorTextDetailDeeper;
  self.labelTitle.textAlignment = NSTextAlignmentCenter;
  
  //self.frame.size.width -CGRectGetMaxX(self.imageView.frame)
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

@end


@interface HomeTabBarView(){
  NSArray* arrayUnselected;
  NSArray* arraySelected;
}

@end

@implementation HomeTabBarView

-(instancetype)initWithDelegate:(id<HomeTabBarItemDelegate>) delegate{
  self = [super init];
  if(self){
    self.delegate = delegate;
    self.frame = CGRectMake(0, 0, kScreenWidth, 49);
    
    arrayUnselected = [NSArray arrayWithObjects:@"tab_icon_message", @"tab_icon_address", @"tab_icon_home", @"tab_icon_schedule", @"tab_icon_me", nil];
    arraySelected = [NSArray arrayWithObjects:@"tab_icon_message_alt", @"tab_icon_address_alt", @"tab_icon_home", @"tab_icon_schedule_alt", @"tab_icon_me_alt", nil];
    [self setupUI];
  }
  return self;
}

-(void)sycnMessageBadgeItemWithValue:(NSString *)stringValue{
  [item1 sycnBadgeItemWithValue:stringValue];
}

-(void)setupUI{
  int itemW = (kScreenWidth)/5;
  
  item1 = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(0, 0, itemW, 49)];

  item1.badgeView.hidden = NO;
  item2 = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(item1.frame.origin.x+item1.frame.size.width, 0, itemW, 49)];
  item3 = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(item2.frame.origin.x+item2.frame.size.width, 0, itemW, 49)];
  item4 = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(item3.frame.origin.x+item3.frame.size.width, 0, itemW, 49)];
  item5 = [[HomeTabBarItem alloc] initWithFrame:CGRectMake(item4.frame.origin.x+item4.frame.size.width, 0, itemW, 49)];
  
  [self addSubview:item1];
  [self addSubview:item2];
  [self addSubview:item3];
  [self addSubview:item4];
  [self addSubview:item5];
  
  UIView* sep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5f)];
  sep.backgroundColor = kColorSplitLine;
  [self addSubview:sep];
  
  
  UIButton* btnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
  btnCenter.frame =  CGRectMake((self.frame.size.width-66)/2, -16, 66, 66);
  [btnCenter setBackgroundImage:[UIImage imageNamed:@"tab_icon_home"] forState:UIControlStateNormal];
  [btnCenter setBackgroundImage:[UIImage imageNamed:@"tab_icon_home"] forState:UIControlStateHighlighted];
  [self addSubview:btnCenter];
  
  [btnCenter addTarget:self action:@selector(btnCenter_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
  
  item1.tag = 1;
  item2.tag = 2;
  item3.tag = 3;
  item4.tag = 4;
  item5.tag = 5;
  
  [item1.imageView setImage:[UIImage imageNamed:arrayUnselected[0]]];
  [item2.imageView setImage:[UIImage imageNamed:arrayUnselected[1]]];
  [item3.imageView setImage:[UIImage imageNamed:arrayUnselected[2]]];
  [item4.imageView setImage:[UIImage imageNamed:arrayUnselected[3]]];
  [item5.imageView setImage:[UIImage imageNamed:arrayUnselected[4]]];
  
  item1.labelTitle.text = @"消息";
  item2.labelTitle.text = @"通讯录";
  item3.labelTitle.text = @"";
  item4.labelTitle.text = @"日程";
  item5.labelTitle.text = @"我的";
	
	item1.selected = false;
	item2.selected = false;
	item3.selected = false;
	item4.selected = false;
	item5.selected = false;
  
  UITapGestureRecognizer *singleTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
  UITapGestureRecognizer *singleTapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
  UITapGestureRecognizer *singleTapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
  UITapGestureRecognizer *singleTapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
  UITapGestureRecognizer *singleTapGestureRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside_gesture:)];
  
  [item1 addGestureRecognizer:singleTapGestureRecognizer1];
  [item2 addGestureRecognizer:singleTapGestureRecognizer2];
  [item3 addGestureRecognizer:singleTapGestureRecognizer3];
  [item4 addGestureRecognizer:singleTapGestureRecognizer4];
  [item5 addGestureRecognizer:singleTapGestureRecognizer5];
  
}

-(void)selectIndex:(int)tabIndex{
	for (UIView *subView in self.subviews) {
		if ([subView isKindOfClass:[HomeTabBarItem class]]) {
			HomeTabBarItem *item = (HomeTabBarItem *)subView;
			if (item.selected && item.tag != tabIndex + 1) {
				[item.imageView setImage:[UIImage imageNamed:arrayUnselected[item.tag - 1]]];
				item.labelTitle.textColor = kColorTextDetailDeeper;
				item.selected = false;
			}
			if (item.tag == tabIndex + 1) {
				[item.imageView setImage:[UIImage imageNamed:arraySelected[tabIndex]]];
				item.labelTitle.textColor = kColorRed;
				item.selected = true;
			}
		}
	}
}

-(void)btnCenter_TouchUpInside:(UIButton*)sender{
  if(self.delegate && [self.delegate respondsToSelector:@selector(homeTabBarItem:touchedIndex:)]){
    [self.delegate homeTabBarItem:item3 touchedIndex:item3.tag];
  }
}

-(void)touchUpInside_gesture:(UIGestureRecognizer*)sender{
  HomeTabBarItem* item = (HomeTabBarItem*)sender.view;
  if(self.delegate && [self.delegate respondsToSelector:@selector(homeTabBarItem:touchedIndex:)]){
    [self.delegate homeTabBarItem:item touchedIndex:item.tag];
  }
}

@end
