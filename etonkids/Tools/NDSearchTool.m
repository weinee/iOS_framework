//
//  NDSearchTool.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//	modifid by weineeL
//

#import "NDSearchTool.h"
#import "NSString+Spell.h"

@implementation NDSearchTool

+ (NDSearchTool *)tool
{
    NDSearchTool *tool = [[NDSearchTool alloc] init];
    return tool;
}

- (NSArray *)searchWithFieldArray:(NSArray *)fieldArray
                      inputString:(NSString *)inputString
                          inArray:(NSArray *)array
{
	if (![array count] || ![fieldArray count]) {
		return nil;
	}
	
	
	NSPredicate *scopePredicate = nil;
	NSMutableArray *backArray = [NSMutableArray array];
	
	
	    for (NSString *fieldString in fieldArray) {
	        NSArray *tempArray = [NSArray array];
	        scopePredicate = [NSPredicate predicateWithFormat:@"SELF.%@ contains[c] %@", fieldString, inputString];
	        tempArray = [array filteredArrayUsingPredicate:scopePredicate];
	        for (NSObject *object in tempArray) {
	            if (![backArray containsObject:object]) {
	                [backArray addObject:object];
	            }
	        }
	    }
	
	return backArray;
}

-(NSArray *)searchWithDescriptionInputString:(NSString *) inputString inArray:(NSArray *)array{
	if (![array count] || ![inputString length]) {
		return nil;
	}
	
	NSMutableString *like = nil;
	for (int i=0; i<inputString.length; i++) {
		if (i==0) {
			like = [NSMutableString stringWithFormat:@"%@", [inputString substringToIndex:1]];
			continue;
		}
		[like appendFormat:@"*%@", [inputString substringWithRange:NSMakeRange(i, 1)]];
	}
	
	NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.description LIKE %@", like];
	NSArray *backArray = [array filteredArrayUsingPredicate:scopePredicate];
	
	return backArray;
}

- (NSArray *)searchWithAllFieldArray:(NSArray *)allFieldArray
                         inputString:(NSString *)inputString
                          inAllArray:(NSArray *)allArray
{
    NSInteger count = allArray.count;
    
    if (allFieldArray.count != allArray.count || 0 == count) {
        return nil;
    }
    
    NSMutableArray *backArray  = [NSMutableArray array];
    
    for (NSInteger i = 0; i < count; i++) {
        NSArray *tempArray = [self searchWithFieldArray:allFieldArray[i] inputString:inputString inArray:allArray[i]];
        [backArray addObject:tempArray];
    }
    
    return backArray;
}

@end
