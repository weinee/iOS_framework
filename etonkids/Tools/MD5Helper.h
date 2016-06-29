//
//  MD5Helper.h
//  eOrder
//
//  Created by jason on 14-8-12.
//  Copyright (c) 2014年 ytd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

#define DEFAULT_CHUNK_SIZE 8*1024   
//8K

@interface MD5Helper : NSObject

+(NSString*)getMD5WithData:(NSData*)data;
+(NSString*)getMd5WithString:(NSString*)data;
+(NSString*)getFileMD5WithPath:(NSString*)path;

@end
