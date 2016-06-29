//
//  NSString+Spell.m
//  HongTu
//
//  Created by weinee on 16/3/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "NSString+Spell.h"

@implementation NSString (Spell)

-(NSString *)tranformToQuanPin{
	if ([self length]) {
		NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
		if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {

		}
		if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
			return ms;
		}
	}
	return nil;
}

-(NSString *)tranformToQuanPinAtFirst:(BOOL)uppper{
	if (![self contentHanZi]) {
		return self;
	}
	NSString *quanpin = [self tranformToQuanPin];
	NSArray *pyArr = [quanpin componentsSeparatedByString:@" "];
	NSMutableString *newString = [NSMutableString string];
	for (NSString *str in pyArr) {
		if(str.length == 0) continue;
		[newString appendString: uppper ? [[str substringToIndex:1] uppercaseString] : [str substringFromIndex:1]];
	}
	return newString;
}

-(BOOL)contentHanZi{
	if (![self length]) {
		return NO;
	}
	for(int i=0; i< [self length]; i++){
		int a = [self characterAtIndex:i];
		if( a > 0x4e00 && a < 0x9fff)
			return YES;
	}
	return NO;
}

- (NSString *)removeSpaceAndNewline
{
	NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
	temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	return temp;
}

-(BOOL)firstCharIsLatter{
	const unichar c = [self characterAtIndex:0];
	if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) {
		return YES;
	}
	return NO;
}
@end
