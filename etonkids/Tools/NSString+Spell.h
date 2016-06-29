//
//  NSString+Spell.h
//  HongTu
//
//  Created by weinee on 16/3/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Spell)
/**
 *  将汉字字符串转换成拼音
 *
 *  @return 汉语全拼
 */
-(NSString *)tranformToQuanPin;

/**
 *  全拼首字母, 有在是汉字的情况下才会转换
 *
 *  @param uppper 是否转换为大写
 *
 *  @return 汉语全拼
 */
-(NSString *)tranformToQuanPinAtFirst:(BOOL) uppper;

/**
 *  判断是否包含汉字
 */
-(BOOL)contentHanZi;

/**
 *  去除所有的空格和换行
 *  @return 去除后的字符串
 */
- (NSString *)removeSpaceAndNewline;

/**
 *  判断首字符是否为字母
 */
-(BOOL)firstCharIsLatter;
@end
