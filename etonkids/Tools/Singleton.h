//
//  Singleton.h
//  TestRongCloud
//
//  Created by 胡凌 on 16/6/7.
//  Copyright © 2016年 C.C. All rights reserved.
//

//.h文件
#ifndef SingletonH
#define SingletonH +(instancetype)sharedInstance;
#endif

//.m文件
#ifndef SingletonM
#define SingletonM \
static id _instance;\
\
+(instancetype)sharedInstance{\
    static dispatch_once_t predicate;\
    dispatch_once(&predicate, ^{\
        _instance = [[super alloc]init];\
    });\
    return _instance;\
}\
\
+(instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t predicate;\
    dispatch_once(&predicate, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
\
+ (id)copyWithZone:(struct _NSZone *)zone{\
    return _instance;\
}
#endif