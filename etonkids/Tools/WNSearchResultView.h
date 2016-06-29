//
//  WNSearchResultView.h
//  HongTu
//
//  Created by weinee on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WNSearchResultView;

typedef void(^PagingResultBlock)(NSMutableArray *array);

@protocol WNSearchResultViewDelegate <NSObject>

@optional

-(void)selectedAtIndex:(NSInteger) index;

/** 当搜索栏输入时调用*/
-(void)resultViewDidSearch:(WNSearchResultView *)resultView searchBar:(UISearchBar *)searchBar;

//一下两个配合使用
-(void)resultView:(WNSearchResultView *)resultView selectedModel:(NSObject *) model;

/** 自行实现搜索结果 并返回， 将会取代默认搜索*/
-(NSMutableArray *)resultView:(WNSearchResultView *)resultView inputString:(NSString *) inputString;

/** 同步和异步只能选其中一个*/
/** （同步） 支持分页搜索，将取代默认搜索和非分页搜索, pageSize 由实现决定*/
-(NSMutableArray *)resultView:(WNSearchResultView *)resultView inputString:(NSString *)inputString page:(NSInteger) page;

/** （异步） 支持分页搜索，将取代默认搜索和非分页搜索, pageSize 由实现决定*/
-(void)asyncResulView:(WNSearchResultView *)resultView inputString:(NSString *)inputString page:(NSInteger) page withResultBolck:(PagingResultBlock) result;

/** 搜索视图将要显示时调用此代理方法*/
-(void)resultViewWillShow:(WNSearchResultView *)resultView;

/** 以下代理是基于使用搜索视图本身作为内部tableView的代理, 暂时放弃*/
-(void)searchResultView:(WNSearchResultView *) resultView tableBeginScroll:(UITableView *)tableView;

@end

@interface WNSearchResultView : UIView

@property (nonatomic, weak) id<WNSearchResultViewDelegate> delegate;

@property (nonatomic, strong) UISearchBar* searchBar;

@property (nonatomic, assign, getter=isHidenNavigationBar) BOOL hidenNavigationBar;

@property (nonatomic, assign) BOOL coverViewLucency;//遮罩层是否半透明

@property (nonatomic, strong) NSMutableArray* searchResult;// 搜索结果

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, assign, getter=isShown) BOOL shown;

/** 动态搜索，边输入变搜索, 默认为YES*/
@property (nonatomic, assign) BOOL dynamicSearch;

/** 自定义搜索的其它视图*/
@property (nonatomic, assign) CGFloat searchViewHeaderHeigth;
@property (nonatomic, strong) UIView *searchViewHeader;

@property (nonatomic, assign) CGFloat searchViewFooterHeigth;
@property (nonatomic, strong) UIView *searchViewFooter;

/**
 *  手动触发搜索
 *
 *  @param searchText 搜索关键字
 */
-(void)doSearch:(NSString *) searchText;

/**
 *  初始化搜索
 *  @param searchBar  使用的searchBar
 *  @param datasource 进行搜索的源数据
 *	@param viewController 搜索所在的controller
 *  @return
 */
-(instancetype)initWithSearchBar:(UISearchBar *)searchBar dateSource:(NSArray *)datasource contentController:(UIViewController*) viewController;
/**
 *  调整通用性
 *
 *  @param tableCellClass 显示结果的cell类
 *  @param modelKeyPath   在cell中model的keypath
 */
-(void)setCellClass:(Class) tableCellClass andModelKeyPath:(NSString *)modelKeyPath searchField:(NSArray <NSString *>*) searchField;

/**
 *  显示到给定的view
 *
 *  @param view 要显示到的父view
 *  @param edge 指定在父view中的边距
 */
-(void)showInView:(UIView *)view edge:(UIEdgeInsets)edge;

-(void) removeWithAnimation:(BOOL) animation;

@end
