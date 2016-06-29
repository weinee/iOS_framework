//
//  CommonTools.m
//  HongTu
//
//  Created by weinee on 16/4/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CommonTools.h"
#import "NSString+Spell.h"
#import "UIImage+HeadImage.h"
#import "UIImageView+WebCache.h"

@implementation CommonTools
//
//+(NSMutableDictionary *)getDicByUserModelArray:(NSArray *)array{
//	if (array == nil || array.count == 0) {
//		return nil;
//	}
//	NSMutableDictionary* modelDic = [NSMutableDictionary dictionary];
//	//使用数组构造分组数据源
//	for (PersDetailModel* model in array) {
//		NSString *firstChar = [[model.displayname_quanpinFirst substringToIndex:1] uppercaseString];//汉语全拼大写的首字母的第一个字符
//		//判断首字符是否为字母
//		BOOL isLatter = [firstChar firstCharIsLatter];
//		firstChar = isLatter ? firstChar : @"#";
//		//判断是否有fistLatter这个关键字
//		if (![modelDic objectForKey:firstChar]) {
//			//创建可变数组
//			NSMutableArray *marr = [NSMutableArray array];
//			[modelDic setObject:marr forKey:firstChar];
//		}
//		[modelDic[firstChar] addObject:model];
//	}
//	//使用描述排序
//	for (NSString* key in modelDic) {
//		NSSortDescriptor* desc = [NSSortDescriptor sortDescriptorWithKey:@"displayname_quanpinFirst" ascending:YES];
//		[modelDic[key] sortUsingDescriptors:@[desc]];
//	}
//	return modelDic;
//}

+(void)addShadowForView:(UIView *)view{
	view.layer.shadowOpacity = 0.5;
	view.layer.shadowOffset = CGSizeZero;
	view.layer.shadowColor = [UIColor grayColor].CGColor;
	view.layer.shadowRadius = 3;
}

+(NSString *)weekIndexSwitchToString:(NSInteger)weekIndex{
	if (weekIndex<1 || weekIndex>7) {
		return nil;
	}
	return @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"][weekIndex-1];
}

+(NSMutableDictionary *)getModelDicFromArray:(NSArray <NSObject*>*)array byModelKeypath:(NSString *)keypath sortByKeyPath:(NSString *)sortKeypath asc:(BOOL)asc{
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	for (NSObject *obj in array) {
		NSString *key = [obj valueForKey:keypath];
		if (![dic objectForKey:key]) {
			//创建可变数组
			NSMutableArray *marr = [NSMutableArray array];
			[dic setObject:marr forKey:key];
		}
		[[dic objectForKey:key] addObject:obj];
	}
	//使用描述排序
	for (NSString* key in dic) {
		NSSortDescriptor* desc = [NSSortDescriptor sortDescriptorWithKey:sortKeypath ascending:asc];
		[dic[key] sortUsingDescriptors:@[desc]];
	}
	return dic;
}

+(void)setImageForAvatar:(UIImageView *)avatar withUsername:(NSString *)username backColor:(UIColor *)color url:(NSString *)url{
	username = username.length > 1 ? [username substringFromIndex:username.length - 2] : username;
	
	UIImage *placehloder = [UIImage creatAvatarWithUsername:username frame:CGRectMake(0, 0, 60, 60) backColor:color fontSize:15];
	if (url) {
		NSURL *URL = [NSURL URLWithString:url];
		[avatar sd_setImageWithURL:URL placeholderImage:placehloder];
	} else{
		avatar.image = placehloder;
	}
}

+(NSData *)archivedWithObject:(id)obj{
	if (!obj) {
		return nil;
	}
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
	return data;
}

+(id)unarchivedWithData:(NSData *)data{
	if (!data) {
		return nil;
	}
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
