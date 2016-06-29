//
//  TreeTableView.h
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//	Modified by weineeL.
//


/** 
 * 添加了对SDAutolayout的依赖
 */

#import <UIKit/UIKit.h>
@class TreeNodeModel, TreeTableView;

@protocol TreeTableViewDelegate <NSObject>

-(void)clickNormalCell: (TreeNodeModel *)node index:(NSInteger) index;

-(void)clickLeafCell: (TreeNodeModel *)node index:(NSInteger) index;

@optional

/** 给当前节点添加叶子节点, 是不是叶子节点自行添加到model*/
-(NSArray *)treeView:(TreeTableView *)treeView getSubNodesForNode:(TreeNodeModel *)currentNode;

@end

@interface TreeTableView : UITableView

@property (nonatomic , weak) id<TreeTableViewDelegate> treeTableViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data;

/**
 *  配置单元格
 *
 *  @param normalCell 非叶子节点的Class
 *  @param leafCell   叶子节点的Class
 *  @param model      节点mode的class , 必须是TreeNodemodel的子类
 *  @param keyPath    model在cell中的keypath
 */
-(void)setNormalCell:(Class) normalCell leafCell:(Class) leafCell normalCellModelKeyPath:(NSString *) normalKeyPath leafCellModelKeyPath:(NSString *) leafKeyPath;

@end
