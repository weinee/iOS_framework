//
//  DropMenuView.m
//  HongTu
//
//  Created by liucong on 16/3/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "DropMenuView.h"
@interface DropMenuView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, assign) BOOL animation;
@property (nonatomic, assign) NSTimeInterval come;
@property (nonatomic, assign) NSTimeInterval go;
@end
static DropMenuView *backgroundView;
static UITableView *tableViewQ;
static CGRect frameQ;
static CGPoint anchorPointQ;

#define HEADERHEIGHT 15
#define HEADERWIDTH 20

@implementation DropMenuView

//
/*
 * frame               设定tableView的位置
 * imagesArr           图片数组
 * dataSourceArr       文字信息数组
 * anchorPoint         tableView进行动画时候的锚点
 * action              通过block回调 确定菜单中 被选中的cell
 * animation           是否有动画效果
 * come                菜单出来动画的时间
 * go                  菜单收回动画的时间
 */
+ (void)configCustomPopViewWithFrame:(CGRect)frame imagesArr:(NSArray *)imagesArr dataSourceArr:(NSArray *)dataourceArr anchorPoint:(CGPoint)anchorPoint seletedRowForIndex:(void(^)(NSInteger index))action animation:(BOOL)animation timeForCome:(NSTimeInterval)come timeForGo:(NSTimeInterval)go{
  frameQ = frame;
  anchorPointQ = anchorPoint;
  if (backgroundView) {
    [DropMenuView removed];
    return;
  }
  UIWindow *window = [UIApplication sharedApplication].keyWindow;
  //背景色
  backgroundView = [[DropMenuView alloc] initWithFrame:window.bounds];
  backgroundView.action = action;
  backgroundView.imagesArr = imagesArr;
  backgroundView.dataSourceArr = dataourceArr;
  backgroundView.animation = animation;
  backgroundView.come = come;
  backgroundView.go = go;
  backgroundView.backgroundColor = [UIColor blackColor];
  backgroundView.alpha = 0.1;
  //添加手势 点击背景能够回收菜单
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:backgroundView action:@selector(handleRemoved)];
  [backgroundView addGestureRecognizer:tap];
  [window addSubview:backgroundView];
	
	//tableHeaderView
	UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, HEADERHEIGHT)];
	header.backgroundColor = [UIColor clearColor];
	CGRect triangleFram = CGRectMake(0, 0, HEADERWIDTH, HEADERHEIGHT);
	UIImageView *triangle = [[UIImageView alloc] initWithFrame:triangleFram];
	triangle.backgroundColor = [UIColor clearColor];
	triangle.center = CGPointMake(frame.size.width - HEADERWIDTH-2, triangle.center.y);
//	triangle.transform = CGAffineTransformMakeRotation(3.14/4);
	triangle.image = [self getTriangle: CGSizeMake(HEADERWIDTH, HEADERHEIGHT)];
	[header addSubview:triangle];
  //tableView
	frame.size.height += HEADERHEIGHT;
  tableViewQ = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
  tableViewQ.delegate = backgroundView;
  tableViewQ.dataSource = backgroundView;
	tableViewQ.tableHeaderView = header;
	tableViewQ.backgroundColor = [UIColor clearColor];
  tableViewQ.separatorInset = UIEdgeInsetsZero;
	tableViewQ.scrollEnabled = NO;
	
  tableViewQ.layer.anchorPoint = anchorPoint;
  //根据锚点位置来确定position
  if (anchorPoint.x == 0 && anchorPoint.y == 0) tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y);
  if (anchorPoint.x == 0 && anchorPoint.y == 0.5) tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y + frameQ.size.height / 2.0);
  if (anchorPoint.x == 0 && anchorPoint.y == 1) tableViewQ.layer.position = CGPointMake(frameQ.origin.x, frameQ.origin.y + frameQ.size.height);
  if (anchorPoint.x == 0.5 && anchorPoint.y == 0) tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y);
  if (anchorPoint.x == 0.5 && anchorPoint.y == 1) tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y + frameQ.size.height);
  if (anchorPoint.x == 1 && anchorPoint.y == 0) tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width, frameQ.origin.y - 20);
  if (anchorPoint.x == 1 && anchorPoint.y == 0.5) tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0);
  if (anchorPoint.x == 1 && anchorPoint.y == 1) tableViewQ.layer.position = CGPointMake(frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height);
//  //设置圆形边框
  tableViewQ.layer.cornerRadius = 3;
  tableViewQ.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
  
  if (animation) {
    [UIView animateWithDuration:come animations:^{
      tableViewQ.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
  }
  [window addSubview:tableViewQ];
 }

+ (void)removed {
  if (backgroundView.animation) {
    backgroundView.alpha = 0;
    [UIView animateWithDuration:backgroundView.go animations:^{
      tableViewQ.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
    } completion:^(BOOL finished) {
      [backgroundView removeFromSuperview];
      backgroundView = nil;
      [tableViewQ removeFromSuperview];
      tableViewQ = nil;
    }];
  }
}
- (void)handleRemoved {
  if (backgroundView) {

    [DropMenuView removed];
  }
}
#pragma mark ---- UITableViewDelegateAndDatasource --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identifile = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifile];
  if (!cell) {
    //选择普通的tableviewCell 左边是图片 右边是文字
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifile];
  }
  cell.imageView.image = [UIImage imageNamed:_imagesArr[indexPath.row]];
  cell.textLabel.text = _dataSourceArr[indexPath.row];
  cell.textLabel.textAlignment = YES;
  cell.textLabel.textColor = [UIColor grayColor];
  cell.textLabel.font = kFontOfSize(14);
	//补全cell分割线长度
  if (CurrentVersion >= 8.0) {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setPreservesSuperviewLayoutMargins:NO];
    [cell setLayoutMargins:UIEdgeInsetsZero];
  }
  return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _dataSourceArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return (tableViewQ.frame.size.height - HEADERHEIGHT)/ _dataSourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (backgroundView.action) {
    [DropMenuView removed];
    _action(indexPath.row);

  } 
}
/** 绘制一个三角形的UIImage*/
+(UIImage *)getTriangle:(CGSize) size{
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	[[UIColor whiteColor] set];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	//根据锚点位置 绘制三角
	if (anchorPointQ.x == 0 && anchorPointQ.y == 0) {
		CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y);
		CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y - 15);
		CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y);
	}
	if (anchorPointQ.x == 0 && anchorPointQ.y == 0.5) {
		CGContextMoveToPoint(context, frameQ.origin.x, frameQ.origin.y  + frameQ.size.height / 2.0 - 13);
		CGContextAddLineToPoint(context, frameQ.origin.x, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
		CGContextAddLineToPoint(context, frameQ.origin.x - 15, frameQ.origin.y  + frameQ.size.height / 2.0);
	}
	if (anchorPointQ.x == 0 && anchorPointQ.y == 1) {
		CGContextMoveToPoint(context, frameQ.origin.x + 12, frameQ.origin.y  + frameQ.size.height);
		CGContextAddLineToPoint(context, frameQ.origin.x + 30, frameQ.origin.y + frameQ.size.height);
		CGContextAddLineToPoint(context, frameQ.origin.x + 10, frameQ.origin.y  + frameQ.size.height + 15);
	}
	if (anchorPointQ.x == 0.5 && anchorPointQ.y == 0) {
		CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y - 15);
	}
	if (anchorPointQ.x == 0.5 && anchorPointQ.y == 1) {
		CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 - 13, frameQ.origin.y + frameQ.size.height);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0 + 13, frameQ.origin.y + frameQ.size.height);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width / 2.0, frameQ.origin.y + frameQ.size.height + 15);
	}
	if (anchorPointQ.x == 1 && anchorPointQ.y == 0) {
		//    CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width - 30, frameQ.origin.y);
		//    CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 10, frameQ.origin.y - 15);
		//    CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width - 12, frameQ.origin.y);
		CGContextMoveToPoint(context, HEADERWIDTH*.5, 0);
		CGContextAddLineToPoint(context, HEADERWIDTH, HEADERHEIGHT);
		CGContextAddLineToPoint(context, 0, HEADERHEIGHT);
		
	}
	if (anchorPointQ.x == 1 && anchorPointQ.y == 0.5) {
		CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 - 13);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height / 2.0 + 13);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height / 2.0);
	}
	if (anchorPointQ.x == 1 && anchorPointQ.y == 1) {
		CGContextMoveToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 12);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width, frameQ.origin.y + frameQ.size.height - 30);
		CGContextAddLineToPoint(context, frameQ.origin.x + frameQ.size.width + 15, frameQ.origin.y + frameQ.size.height  - 10);
	}
	CGContextClosePath(context);
	[[UIColor whiteColor] setFill];
	[[UIColor whiteColor] setStroke];
	CGContextDrawPath(context, kCGPathFillStroke);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end

