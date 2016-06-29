//
//  CommonTools.h
//  HongTu
//
//  Created by weinee on 16/4/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 通用工具类，可以把一些通用逻辑封装在这里*/

@interface CommonTools : NSObject
/**
 *  分组，传入一个用户模型的数组，返回一个字典，字典每个关键字对应了一组由相同用户名首字母组成的数组，数组中要排序
 *
 *  @param array 用户模型的数组
 *
 *  @return 字典每个关键字对应了一组由相同用户名首字母组成的数组
 */
//+(NSMutableDictionary *) getDicByUserModelArray: (NSArray *) array;

/**
 *  给视图添加普通阴影
 *
 *  @param view 要添加阴影的视图
 */
+(void) addShadowForView:(UIView *)view;

/**
 *  将整形数据转换成汉字星期， 周日为0
 *
 *  @param weekIndex 1 -- 7
 *
 *  @return 星期天 -- 星期一, 输入不合法是返回nil
 */
+(NSString *)weekIndexSwitchToString:(NSInteger) weekIndex;

/**
 *   将一个model数组，按照某个属性分组
 *
 *  @param array       待分组的数组
 *  @param keypath     使用model中某个属性的keypath
 *  @param sortKeypath 每个分组根据某个属性排序
 *
 *  @return 分组后的字典
 */
+(NSMutableDictionary *)getModelDicFromArray:(NSArray <NSObject*>*) array byModelKeypath:(NSString *)keypath sortByKeyPath:(NSString *)sortKeypath asc:(BOOL) asc;


+(void) setImageForAvatar:(UIImageView *)avatar withUsername:(NSString *)username backColor:(UIColor *)color url:(NSString *)url;

/** 归档*/
+(NSData *)archivedWithObject:(id)obj;

/** 解档*/
+(id)unarchivedWithData:(NSData *)data;
@end
