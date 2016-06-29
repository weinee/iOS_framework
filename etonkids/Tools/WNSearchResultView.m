//
//  WNSearchResultView.m
//  HongTu
//
//  Created by weinee on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "WNSearchResultView.h"
#import "UIView+SDAutoLayout.h"
#import "NDSearchTool.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "XYString.h"

#define OFFSET 50
#define ANIMATEDURATION 0.3
#define NavigateHegth 64
#define LIMITPERPAGE 10

typedef enum RespondsToSelector {
	RespondsToSelector_selectedAtIndex = 1,
	RespondsToSelector_resultViewDidSearch_searchBar = 1 << 1,
	RespondsToSelector_resultView_selectedModel = 1 << 2,
	RespondsToSelector_resultView_inputString = 1 << 3,
	RespondsToSelector_resultView_inputString_page = 1 << 4,
	RespondsToSelector_asyncResulView_inputString_page = 1 << 5,
	RespondsToSelector_resultViewWillShow = 1 << 6
}RespondsToSelector;

@interface WNSearchResultView ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

//自定义单元格
@property (nonatomic, assign) Class tableCellClass;
@property (nonatomic, copy) NSString *modelKeyPath;

//searchBar的内容视图
@property (nonatomic, strong) UIView *searchContent;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, weak) UISearchBar* originSearchBar;

//searchBar所在的controller
@property (nonatomic, weak) UIViewController* contentViewController;

@property (nonatomic, weak) NSArray* datasource;

@property (nonatomic, strong) NSArray<NSString*> *searchField;

@property (nonatomic, assign) RespondsToSelector respondsToSelectorType;

@end

//static NSString *CellID = @"SearchCell";
@implementation WNSearchResultView
@synthesize searchViewFooter = _searchViewFooter;

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar dateSource:(NSArray *)datasource contentController:(UIViewController *)viewController
{
	self = [super init];
	if (self) {
		_shown = NO;
		
		_hidenNavigationBar = YES;
		_dynamicSearch = YES;
		_coverViewLucency = YES;
		_searchViewFooterHeigth = 0.0;
		_searchViewHeaderHeigth = 0.0;
		
		_datasource = datasource;
		
		_originSearchBar = searchBar;
		self.searchBar.searchBarStyle = searchBar.searchBarStyle;
		self.searchBar.placeholder = searchBar.placeholder;
		[[self.searchBar valueForKey:@"_cancelButton"] setTitle:@"取消"];
		
		//给原来的searchBar添加点击手势
		UIView *searchCoverView = [[UIView alloc] initWithFrame:searchBar.frame];
		searchCoverView.backgroundColor = [UIColor clearColor];
		[searchBar.superview addSubview:searchCoverView];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(triggerShow:)];
		tap.delegate = self;
		[searchCoverView addGestureRecognizer:tap];
		
		//传入viewController
		_contentViewController = viewController;
    
		
	}
	return self;
}

-(void)setCellClass:(Class)tableCellClass andModelKeyPath:(NSString *)modelKeyPath searchField:(NSArray<NSString *> *)searchField{
	_tableCellClass = tableCellClass;
	_modelKeyPath = modelKeyPath;
	//注册单元格
	[self.tableView registerClass:_tableCellClass forCellReuseIdentifier:NSStringFromClass(_tableCellClass)];
	
	self.searchField = searchField;
}

/**
 *  默认方式显示
 */
-(void)show{
	//布局
	[self doLayoutSubView];
	
	if (self.respondsToSelectorType & RespondsToSelector_resultViewWillShow) {
		[self.delegate resultViewWillShow:self];
	}
	
	if (self.searchBar.text.length > 0) {
		self.searchBar.text = @"";
	}
	
	self.shown = YES;
	[self.originSearchBar becomeFirstResponder];//先让原来的searchBar作为第一响应者，可以看到动画效果
	
	if (self.isHidenNavigationBar) {
		self.frame = _contentViewController.view.frame;
		//隐藏navigationBar
		[_contentViewController.navigationController setNavigationBarHidden:YES animated:YES];
	} else{
		self.frame = CGRectMake(0, NavigateHegth, _contentViewController.view.frame.size.width, _contentViewController.view.frame.size.height - NavigateHegth);
	}
	
	self.alpha = 0;
	[_contentViewController.view addSubview:self];
	
	//	searchBar 上移动画, 渐显动画
	[UIView animateWithDuration:ANIMATEDURATION animations:^{
		self.originSearchBar.transform = CGAffineTransformMakeTranslation(self.originSearchBar.frame.origin.x, self.originSearchBar.frame.origin.y - OFFSET);
		//动画显示
		self.alpha = 1;
	} completion:^(BOOL finished) {
		// 动画结束后，从父视图隐藏
		self.originSearchBar.hidden = YES;
		//让现在使用的searchBar成为第一响应者
		[self.searchBar becomeFirstResponder];
	}];

}

-(void)showInView:(UIView *)view edge:(UIEdgeInsets)edge{
	//修改fram
	
	self.hidden = 0;
	[view addSubview:self];
	//动画显示
	self.hidden = 1;
}

/** 移除*/
-(void) remove{
	[self removeWithAnimation:YES];
}

-(void)removeWithAnimation:(BOOL)animation{
	self.shown = NO;
	//隐藏tableView
	self.tableView.hidden = YES;
	if (self.isHidenNavigationBar) {
		[self.contentViewController.navigationController setNavigationBarHidden:NO animated:animation];
	}
	
	self.originSearchBar.hidden = NO;
	[UIView animateWithDuration:animation ? ANIMATEDURATION : 0.0 animations:^{
		//原来的searchBar恢复到原来的位置
		self.originSearchBar.transform = CGAffineTransformIdentity;
	}];
	
	[self removeFromSuperview];
}

#pragma mark 手势触发
-(void)triggerShow:(UIGestureRecognizer *)gesture{
	if ([XYString isBlankString:NSStringFromClass(self.tableCellClass)] || [XYString isBlankString:self.modelKeyPath]) {
		NSAssert(NO, @"必须设置cell的类和模型在自定义cell中的keypath");
		return;
	}
	[self show];
}

#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	if (!self.dynamicSearch) {
		return;
	}
	if (searchText == nil || [@"" isEqualToString:searchText]) {
		self.tableView.hidden = YES;
		return;
	}

	[self doSearch:searchText];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

	[self doSearch:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[self removeWithAnimation:YES];
}

/** 进行搜索*/
-(void)doSearch:(NSString *) searchText{
	
	//显示tableView
	self.tableView.hidden = NO;
	
	//进行搜索
	/** 判断是否实现分页搜索*/
	if ((self.respondsToSelectorType & RespondsToSelector_resultView_inputString_page) || (self.respondsToSelectorType & RespondsToSelector_asyncResulView_inputString_page)) {
		
		//分页初始化
		static int page;
		//		self.tableView.mj_footer = nil;
		self.searchResult = [NSMutableArray array];
    page = 0;
		
		//		获取第一页数据，避免使用自动刷新获取第一页的数据
		if (self.respondsToSelectorType & RespondsToSelector_asyncResulView_inputString_page) {
			
      [self.delegate asyncResulView:self inputString:searchText page:page++ withResultBolck:^(NSMutableArray *array) {
        if (array) {
            [self.searchResult addObjectsFromArray: array];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
        
      }];
			
		} else if (self.respondsToSelectorType & RespondsToSelector_resultView_inputString_page){
			
      [self.searchResult addObjectsFromArray:[self.delegate resultView:self inputString:searchText page:page++]];
      [self.tableView.mj_footer endRefreshing];
			[self.tableView reloadData];
			
		}
		
		//添加上拉加载控件
		MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
			//添加搜索结果
			if (self.respondsToSelectorType & RespondsToSelector_asyncResulView_inputString_page) {
				[self.delegate asyncResulView:self inputString:searchText page:page++ withResultBolck:^(NSMutableArray *array) {
          [self.searchResult addObjectsFromArray: array];
          [self.tableView.mj_footer endRefreshing];
					[self.tableView reloadData];
					if (array.count > 0) {
						[self.tableView.mj_footer endRefreshing];
					} else{
						[self.tableView.mj_footer endRefreshingWithNoMoreData];
					}
				}];
				
			} else if (self.respondsToSelectorType & RespondsToSelector_resultView_inputString_page){
				
				NSMutableArray *pageArr = [self.delegate resultView:self inputString:searchText page:page++];
				
				[self.searchResult addObjectsFromArray:pageArr];
				[self.tableView reloadData];
				if (pageArr.count > 0) {
					[self.tableView.mj_footer endRefreshing];
				} else{
					[self.tableView.mj_footer endRefreshingWithNoMoreData];
				}
			}
			
		}];
		footer.stateLabel.font = kFontOfSize(12);
		self.tableView.mj_footer = footer;
		//		[self.tableView.mj_footer beginRefreshing];//触发一次搜索
		
		//返回
		return;
	}
	
	/** 判断是否自己实现了搜索, 没有分页*/
	if (self.respondsToSelectorType & RespondsToSelector_resultView_inputString) {
		
		self.searchResult = [self.delegate resultView:self inputString:searchText];
		
	} else{
		
		self.searchResult = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:self.searchField inputString:searchText inArray:self.datasource];
		
	}
	if (self.respondsToSelectorType & RespondsToSelector_resultViewDidSearch_searchBar) {
		
		[self.delegate resultViewDidSearch:self searchBar:_searchBar];
	
	}
	
	[self.tableView reloadData];
}

#pragma mark get model
-(NSObject *) getSearchCellModel:(NSIndexPath *) indexPath{
	
	if (self.searchResult.count <= 0) {
		return nil;
	}
	
	return self.searchResult[indexPath.row];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	if ([self.searchBar isFirstResponder]) {
		[self.searchBar resignFirstResponder];
	}
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//	static NSInteger _lastPosition;
//	/** 调用代理*/
//	if ([self.delegate respondsToSelector:@selector(searchResultView:tableBeginScroll:)]) {
//		[self.delegate searchResultView:self tableBeginScroll:self.tableView];
//	}
//}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.searchResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//获取model
	NSObject *model;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(_tableCellClass) forIndexPath:indexPath];
	model = [self getSearchCellModel:indexPath];
	[cell setValue:model forKey:_modelKeyPath];
	
  if (CurrentVersion >= 8.0) {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setPreservesSuperviewLayoutMargins:NO];
    [cell setLayoutMargins:UIEdgeInsetsZero];
  }
	
	[tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
	
	// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
	cell.sd_tableView = tableView;
	cell.sd_indexPath = indexPath;
	return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//判断当前选择的行在，searchDatasource中的下标, 并调用代理方法
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (self.respondsToSelectorType & RespondsToSelector_selectedAtIndex) {
		[self.delegate selectedAtIndex:[self.datasource indexOfObject:[self getSearchCellModel:indexPath]]];
	}
	
	if (self.respondsToSelectorType & RespondsToSelector_resultView_selectedModel) {
		[self.delegate resultView:self selectedModel:_searchResult[indexPath.row]];
	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	Class currentClass = _tableCellClass;
	
	NSObject *model;
	model = [self getSearchCellModel:indexPath];
	return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
}

/** SDAutolayout适配ios7 的方法*/
- (CGFloat)cellContentViewWith
{
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	// 适配ios7
	if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
		width = [UIScreen mainScreen].bounds.size.height;
	}
	return width;
}

#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	if (self.isShown) {
		return NO;
	}
	return YES;
}

#pragma mark 视图懒加载
-(UITableView *)tableView{
	if (_tableView) {
		return _tableView;
	}
	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.hidden = YES;
  _tableView.separatorInset = UIEdgeInsetsZero;
	[self addSubview:_tableView];
	return _tableView;
}

-(UIView *)coverView{
	if (_coverView) {
		return _coverView;
	}
	_coverView = [[UIView alloc] init];
	
	if (self.coverViewLucency) {
		_coverView.backgroundColor = [UIColor blackColor];
		_coverView.alpha = 0.2;
	} else {
		_coverView.backgroundColor = [UIColor whiteColor];
	}
	
	[self addSubview:_coverView];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
	[_coverView addGestureRecognizer:tap];
	[self sendSubviewToBack:_coverView];
	return _coverView;
}

-(UISearchBar *)searchBar{
	if (_searchBar) {
		return _searchBar;
	}
	_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
	_searchBar.delegate = self;
	_searchBar.showsCancelButton = YES;
	[self.searchContent addSubview:self.searchBar];
	return _searchBar;
}

-(UIView *)searchContent{
	if (_searchContent) {
		return _searchContent;
	}
	_searchContent = [[UIView alloc] init];
	_searchContent.backgroundColor = [UIColor whiteColor];
	[self addSubview:_searchContent];
	return _searchContent;
}


/** 布局视图*/
-(void)doLayoutSubView{
	[self addSubview:self.searchViewFooter];
	[self addSubview:self.searchViewHeader];
	
	self.searchContent.sd_layout
	.topSpaceToView(self, _hidenNavigationBar ? 20 : 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.heightIs(44);
	
	self.coverView.sd_layout
	.topSpaceToView(self.searchContent, 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.bottomEqualToView(self);
	
	self.searchViewHeader.sd_layout
	.topSpaceToView(self.searchContent, 0)
	.rightEqualToView(self)
	.leftEqualToView(self)
	.heightIs(_searchViewHeaderHeigth);
	
	self.searchViewFooter.sd_layout
	.leftEqualToView(self)
	.rightEqualToView(self)
	.bottomEqualToView(self)
	.heightIs(_searchViewFooterHeigth);
	
	self.tableView.sd_layout
	.topSpaceToView(_searchViewHeaderHeigth == 0.0 ? self.searchContent : self.searchViewHeader, 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.bottomSpaceToView(_searchViewFooterHeigth == 0.0 ? self : self.searchViewFooter, 0);
	
	self.searchBar.sd_layout
	.topSpaceToView(self.searchContent, 6)
	.leftEqualToView(self.searchContent)
	.rightEqualToView(self.searchContent)
	.bottomEqualToView(self.searchContent);
	
}

-(UIView *)searchViewFooter{
	if (_searchViewFooter) {
		return _searchViewFooter;
	}
	_searchViewFooter = [[UIView alloc] init];
	return _searchViewFooter;
}

-(UIView *)searchViewHeader{
	if (_searchViewHeader) {
		return _searchViewHeader;
	}
	_searchViewHeader = [[UIView alloc] init];
	return _searchViewHeader;
}

#pragma mark setter
-(void)setDelegate:(id<WNSearchResultViewDelegate>)delegate{
	_delegate = delegate;
	
	self.respondsToSelectorType = 0;
	
	if ([_delegate respondsToSelector:@selector(selectedAtIndex:)]) {
		self.respondsToSelectorType |= RespondsToSelector_selectedAtIndex;
	}
	
	if ([_delegate respondsToSelector:@selector(resultViewDidSearch:searchBar:)]) {
		self.respondsToSelectorType |= RespondsToSelector_resultViewDidSearch_searchBar;
	}
	
	if ([_delegate respondsToSelector:@selector(resultView:selectedModel:)]) {
		self.respondsToSelectorType |= RespondsToSelector_resultView_selectedModel;
	}
	
	if ([_delegate respondsToSelector:@selector(resultView:inputString:)]) {
		self.respondsToSelectorType |= RespondsToSelector_resultView_inputString;
	}
	
	if ([_delegate respondsToSelector:@selector(resultView:inputString:page:)]) {
		self.respondsToSelectorType |= RespondsToSelector_resultView_inputString_page;
	}
	
	if ([_delegate respondsToSelector:@selector(asyncResulView:inputString:page:withResultBolck:)]) {
		self.respondsToSelectorType |= RespondsToSelector_asyncResulView_inputString_page;
	}
	
	if ([_delegate respondsToSelector:@selector(resultViewWillShow:)]) {
		self.respondsToSelectorType |= RespondsToSelector_resultViewWillShow;
	}
}

#pragma mark dealloc
-(void)dealloc{
	self.modelKeyPath = nil;
	self.searchContent = nil;
	self.coverView = nil;
	self.searchBar = nil;
	self.tableView = nil;
	self.searchResult = nil;
}


@end
