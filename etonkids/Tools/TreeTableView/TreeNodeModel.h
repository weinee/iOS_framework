//
//  Node.h
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//	Modified by weineeL.
//

#import <Foundation/Foundation.h>

/**
 *  每个节点类型
 */
@interface TreeNodeModel : NSObject

@property (nonatomic , assign) NSInteger parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) NSInteger nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) NSInteger depth;//该节点的深度， 默认为零

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态

@property (nonatomic, assign) BOOL isLeaf;//是否为叶子节点

@property (nonatomic, assign) BOOL isRoot;//从写此getter可用来作为是否显示在第一层的判断
/**
 *	快速实例化该对象模型
 */
- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name isLeaf : (BOOL)leaf expand : (BOOL)expand;

@end
