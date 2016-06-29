//
//  TreeViewCellTableViewCell.m
//  HongTu
//
//  Created by weinee on 16/5/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "TreeViewCell.h"

@implementation TreeViewCell

/** 重写布局，进行缩进*/
-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat offset = self.indentationLevel * self.indentationWidth;//偏移量
	//实现自定义cell的缩进
	CGRect rect = self.contentView.frame;
	rect.origin.x = offset;
	self.contentView.frame = rect;
	
}

@end
