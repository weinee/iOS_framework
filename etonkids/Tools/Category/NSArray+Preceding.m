//
//  NSArray+Preceding.m
//  HongTu
//
//  Created by Arlen on 16/5/16.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "NSArray+Preceding.h"

@implementation NSArray (Preceding)

-(NSObject *)precedingObjectWithTargetItem:(NSObject *)obj{
  if (![self containsObject:obj]) {
    return nil;
  }
  for (int i = 0; self.count; i++) {
    if (obj == [self objectAtIndex:i]) {
      if (i == 0) {
        return nil;
      }
      else
      {
        return [self objectAtIndex:i - 1];
      }
    }
  }
  return nil;
}

@end
